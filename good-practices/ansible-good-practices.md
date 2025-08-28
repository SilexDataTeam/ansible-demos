# Ansible Good Practices

This document contains Silex's recommendations for good practices around Ansible Development. There are not necessarily *best* practices as each environment is unique, but there are some opinionated expectations Ansible has.

## General Naming

1. Roles and Groups should be named with underscores to separate words (e.g. manage_apache)
2. Tags should be named with hyphens to separate words (e.g. run-daily)
3. Role Name suggestions
    - manage_foo : Ongoing/regularly applied idempotent role
    - setup_foo : Infrequent/ad-hoc setup to enable use of a system/software/application
4. Documentation should be saved in README.md files within the repository, role, etc. (note capitalization)

## Variable Naming

1. Variable names should be prefixed with the name of the role and separated with two underscores. This avoids collisions of variable names from different modules/roles.
    - Example: setup_apache__username: apache
2. Internal variables should be prefixed with two underscores.
    - Example: register: __search_results
3. Loop variables should be prefixed with one underscore.
    - Example:

      ```yaml
      - name: Print Information
        ansible.builtin.debug:
          msg: "Host: {{ _host.name }}"
        loop: "{{ __host_list }}"
        loop_control:
        loop_var: _host
      ```

4. Internal variables should never be defined directly in the inventory. There is usually a "public" role variable that will coalesce into the "private" variable. Generally checking the defaults/main.yml is a good place to start for those.

## Variable Values/Validation

1. The most reliable way to ensure variables are defined and have a value is to provide a default value and check for length > 0.
    - Example: when: role_name__variable_name | d('') | length > 0
    - This can be used for lists (`d([])`) and dictionaries (`d({})`) as well
2. If variables are **required** for a role/playbook, assert that they are defined as the first tasks.
    - One note here is that if a role has default values, in some instances the assertion will happen before those values are used.

## Playbook Development

1. Try to never specify `hosts: localhost` as the playbook hosts target. Instead, opt for a purpose-defined group that contains `localhost` as the only member of the group. This allows for a level of abstraction to:
    - offer flexibility in defining any group_vars for the respective purpose group(s) when and if needed and
    - to not impact other playbooks that might use the localhost in other ways since they would have respective purpose groups set up in the same way.
    - provide ability to change the hosts if ever needed in the future without having to revise/modify the respective playbooks.

## Role Development

1. If a variable is required for a role, ensure that it is defined in defaults/main.yml
2. If a variable does not have a good default, place it in defaults/main.yml  with a comment stating such and an empty value (string, list, dictionary as appropriate). The role should then assert that the variable is defined as one of the first plays.
3. If using an assert for variables, make sure the fail_msg  is defined with what is expected. The msg  should, where appropriate, display the value of the variable so it is clear what is being used.
4. When needing to limit tasks with a conditional, avoid putting names of things in code itself. Instead of using `when: '"app_xyz" in group_names'`, include a relevant variable in the inventory such as `app_xyz__perform_action: true` and use `when: app_xyz__perform_action` as your when clause.

## Collection Development

Collection recommendations are being documented.

## git Development

### Squashing Commits

1. git commit messages such as 'Testing' or 'Rename variable' are largely unhelpful in the future. Instead, squash the commits of the feature branch before creating a Pull Request and create a commit message that will be meaningful to future developers.

### Rebasing Your Branch

1. If you have a branch that has been around for a while, the development or main branch may have had additional changes made to it and can potentially cause merge conflicts down the line. One way to resolve this is to rebase your branch on top of the current development or main branch, not the point in time as it existed when your feature branch was created. To do this:
    - In your branch, run git rebase origin/development (this will download the latest development from Bitbucket and replay your changes on top).
    - Push the updates to your feature branch, as the commit ID will have changed. Run git push --force

### Creating Pull Requests

1. Frequent commits during the development process are helpful but are left to the developer's preference.
Before creating the Pull Request for others to review, please squash commits to a small number of meaningful commit messages.
2. **REVIEW YOUR PR** and ensure that ONLY the commit(s) that contain your change are included. If there are additional unrelated commits, update the PR to ensure they're not included either by recreating your branch from the most recent version of the source branch or possible by rebasing.

## Job Templates

1. Extra Vars - avoid using extra vars on job templates in favor of defining variables in role variables or the inventory.
2. If another system (Jenkins, etc.) needs to pass data to the playbook, extra vars may be used and the 'Prompt on Launch' box for the Variables field must be checked for that data to be used.
3. If a user needs to pass data to the playbook, avoid extra variables and instead use a Survey attached to the Job Template so that some guidance can be provided.
