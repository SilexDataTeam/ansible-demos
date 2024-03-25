# Ansible Collection - silex.soap

## silex.soap.numbers_to_words

### Description

Example using Powershell and Ansible to query a SOAP API. Built using the examples at the [Postman Documenter](https://documenter.getpostman.com/view/8854915/Szf26WHn#ce8589ab-0fc5-493c-9792-93e5d427e608).

When given an integer that meets the requirements set forth on <https://www.dataaccess.com/webservicesserver/NumberConversion.wso?op=NumberToWords> it will return a string of words.

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

```
TASK [Current Year To Words] *************************************************************************************************************************************************
ok: [win11ws.silex.local] => {"changed": false, "words": "two thousand twenty four"}

TASK [Display converted number] *********************************************************************************************************************************************
ok: [win11ws.silex.local] => {
    "msg": "The current year is two thousand twenty four."
}

PLAY RECAP ******************************************************************************************************************************************************************
win11ws.silex.local        : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```