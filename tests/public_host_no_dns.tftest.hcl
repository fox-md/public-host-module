run "random_host" {
  module {
    source = "./tests/random_name"
  }
}

run "create_host" {
  command = apply

  module {
    source = "./"
  }

  variables {
    name              = run.random_host.name
    vpc_id            = var.vpc_id
    ubuntu_version    = var.ubuntu_version
    key_name          = var.key_name
    domain_name       = var.domain_name
    create_dns_record = false
    ingress_rules     = var.ingress_rules
    egress_rules      = var.egress_rules
  }
}

run "check_public_ip_allocation" {
  command = plan

  assert {
    condition     = run.create_host.instance_public_ip == ""
    error_message = "Public ip address not empty: ${run.create_host.instance_public_ip}"
  }

  assert {
    condition     = run.create_host.fqdn == null
    error_message = "Expected FQDN to be null."
  }
}

run "website_responded_200_with_correct_response_body" {
  command = plan

  module {
    source = "./tests/http"
  }

  variables {
    url = "${var.http_protocol}://${run.create_host.public_ip}"
  }

  assert {
    condition     = data.http.index.status_code == 200
    error_message = "Website responded with HTTP status ${data.http.index.status_code}"
  }

  assert {
    condition     = strcontains(data.http.index.response_body, "Welcome to nginx!")
    error_message = "Website reponse body does not include expected text"
  }
}

run "stop_instance" {
  command = apply

  module {
    source = "./tests/stop_instance"
  }

  variables {
    instance_id = run.create_host.instance_id
  }
}

run "expected_stopped_state" {
  command = plan

  module {
    source = "./tests/instance_state"
  }

  variables {
    instance_id = run.create_host.instance_id
  }

  assert {
    condition     = data.aws_instance.this.instance_state == "stopped"
    error_message = "Instance state is expected to be 'stopped', actual '${data.aws_instance.this.instance_state}'"
  }
}

run "start_instance" {
  command = apply

  module {
    source = "./tests/start_instance"
  }

  variables {
    instance_id = run.create_host.instance_id
  }
}

run "expected_running_state" {
  command = plan

  module {
    source = "./tests/instance_state"
  }

  variables {
    instance_id = run.create_host.instance_id
  }

  assert {
    condition     = data.aws_instance.this.instance_state == "running"
    error_message = "Instance state is expected to be 'running', actual '${data.aws_instance.this.instance_state}'"
  }
}

run "website_responded_200_after_restart" {
  command = plan

  module {
    source = "./tests/http"
  }

  variables {
    url = "${var.http_protocol}://${run.create_host.public_ip}"
  }

  assert {
    condition     = data.http.index.status_code == 200
    error_message = "Website responded with HTTP status ${data.http.index.status_code}"
  }
}
