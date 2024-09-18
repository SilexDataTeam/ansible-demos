# Install and configure Apache webserver using Ansible Lightspeed

## Overview

This Playbook installs Apache webserver(httpd), opens port 80 on webserver, create a custom index.html page and starts the `httpd` service.  

The demo illustrates:

* Generate multi-task suggestions
* How you can use natural language prompts to create a functional playbook

## Demo preparation if not using Instruqt environment

1. Install the VS Code extension and activate Ansible Lightspeed using resources in the [getting started guide](../../../docs/getting_started.md).
2. If not running this example in the Ansible self-paced labs environment, create an Ansible Inventory file with a `rhel` Ansible inventory group with the corresponding Linux target host(s) details.

* [Example Ansible inventory file](./inventory/inventory.yml)

```yaml
---
all:
  children:
    rhel:
      hosts:
        rhel-01:
          ansible_host: "Your Ansible target host"
  vars:
    ansible_ssh_private_key_file: 'Your SSH private key file'
    ansible_user: 'Your Ansible user'
    ansible_host_key_checking: false
```

## Tested content

The model continues to improve and evolve with each release and generated suggestions could differ from the examples provided. Tested content is available in the corresponding [`solution_install_apache.yml`](./solution_install_apache.yml) Playbook.

## Running the demo

Run the steps below in the [./playbooks/infra/install_apache/demo_install_apache.yml](./demo_install_cockpit.yml) Ansible Playbook.

### Step

#### Generate multi-task `# Install apache webserver & open firewall port 80 for the webserver & create a custom index.html file that has "I'm a custom website" as content & start the service`

* First task - Install apache on the server
* Second task - Opens port 80 on webserver
* Third task - Creates a custom index.html with content "I'm a custom website"
* Fourth task - Starts the httpd service

## Executing the Playbook

You can can choose to run the `demo_install_apache.yml` Playbook using **Ansible automation controller** (formerly Ansible Tower) or  `ansible-navigator`.

### **Option 1: Using automation controller - Instruqt only!**

### **Option 2: using ansible-navigator**

* Open a terminal in VS Code by clicking on `Terminal` and `New Terminal`.
![vscode_open_terminal.png](../../../assets/img/vscode_open_terminal.png)
![vscode_terminal_window.png](../../../assets/img/vscode_terminal_window.png)
* In the terminal window, navigate to the `playbooks/infra/install_apache/` folder.

```bash
cd playbooks/infra/install_apache
```

* Run the ansible-navigator command in the terminal

```bash
ansible-navigator run demo_install_apache.yml
```

Wait for the playbook run to complete.

* Press the `ESC` key to return to the prompt.

---
