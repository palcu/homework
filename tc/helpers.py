def is_allowed_first_char_for_id(c):
    return is_letter(c) or c in ['_']

def is_allowed_char_for_id(c):
    return is_allowed_first_char_for_id(c) or is_digit(c)

def is_not_allowed_char_for_id(c):
    return not is_allowed_char_for_id(c)

def is_letter(c):
    return 'a' <= c <= 'z' or 'A' <= c <= 'Z'

def is_digit(c):
    return c.isdigit()

def anything(c):
    return True

def is_space(c):
    return ' ' == c

def is_newline(c):
    return '\n' == c

def is_tab(c):
    return '\t' == c

def is_character(c):
    return c in ['*', '+', '-', '(', ')', '[', ']', '{', '}', ':', '=', '.', ',', '>', '<', '!']

def is_hash(c):
    return c == '#'

def is_simple_quote(c):
    return c == "'"

def is_double_quote(c):
    return c == '"'

def is_negative_sign(c):
    return c == '-'

def is_point(c):
    return c == '.'

def is_escape(c):
    return c == '\\'

def is_character_can_be_followed_by_equal(c):
    return c in ['+', '-', '*', '/', '<', '>']

def is_equal(c):
    return c == '='
