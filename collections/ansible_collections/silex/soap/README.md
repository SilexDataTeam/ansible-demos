# Ansible Collection - silex.soap

## silex.soap.numbers_to_words

### Description

Example using Powershell and Ansible to query a SOAP API. Built using the examples at the [Postman Documenter](https://documenter.getpostman.com/view/8854915/Szf26WHn#ce8589ab-0fc5-493c-9792-93e5d427e608).

When given an integer that meets the requirements set forth on <https://www.dataaccess.com/webservicesserver/NumberConversion.wso?op=NumberToWords>

### Example

```yaml
    - name: Current Year To Words
      silex.soap.numbers_to_words:
        convert_number: "{{ lookup('ansible.builtin.pipe', 'date +%Y') }}"
      register: __converted_number

    - name: Display Current Year in Words
      ansible.builtin.debug:
        msg: "The current year is {{ __converted_number.words }}."
```
