#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2024, Matthew Hyclak (@mhyclak-silex)
# Copyright: (c) 2020, Brian Scholer (@briantist)
# Copyright: (c) 2015, Jon Hawkesworth (@jhawkesworth) <figs@unity.demon.co.uk>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: numbers_to_words
short_description: Converts integers to English words using a SOAP API
description:
- Accepts an integer and returns a trimmed string of words for that number
options:
  convert_number:
    description:
    - Positive integer to be converted to words.
    type: int
    required: yes
notes:
- This module is built on the Postman example at https://documenter.getpostman.com/view/8854915/Szf26WHn#ce8589ab-0fc5-493c-9792-93e5d427e608
seealso:
author:
- Matthew Hyclak (@mhyclak-silex)
'''

EXAMPLES = r'''
- name: Get words for the current year
  silex.soap.numbers_to_words:
    convert_number: "{{ lookup('ansible.builtin.pipe', 'date +%Y') }}"

'''

RETURN = r'''
words:
  description: the string of words converted from the number
  returned: always
  type: str
  sample: two thousand twenty four
'''