def other_stuff():
	escaped_string = 'escaped \
string'
	escaped = 'miau \' miau'
	escaped2 = 'ham \\ ham'
	pi = 3.14
	nicer_float = 3.
	pi += 3
	whatever34alex = 45
	this_is_a_string = 'this is a string'
	y = -3.14
	x += 1

# suporta doar indentare de taburi
# nu suporta stringuri cu ""

from helpers import *
from time import sleep
from sys import exit


class Tokenizer():
	KEYWORDS = ['from', 'import', 'class', 'def', '__init__', 'self', 'with', 'as', 'if', 'len', 'raise', 'Exception', 'True', 'False']

	def __init__(self, filepath):
		with open(filepath) as stream:
			self.source_code = stream.read()
		self.position = 0

	def gettoken(self):
		dfa = Dfa(self.source_code[self.position:])

		# import ipdb; ipdb.set_trace()
		token_val, token_type, consumed_chars = dfa.run()

		self.position += consumed_chars

		if token_type == 'IDENT':
			if token_val in self.KEYWORDS:
				token_type = 'KEYWORD'
		elif token_type == 'NEWLINE':
			token_val = len(token_val) - 1
			token_type = 'INDENTATION'
		elif token_type == 'CHARACTER_CAN_BE_FOLLOWED_BY_EQUAL':
			token_type = 'OPERATOR'
		elif token_type == 'STRING_SIMPLE_QUOTES_END':
			token_type = 'STRING'
		elif token_type == 'CHARACTER':
			token_type = 'OPERATOR'
		elif token_type == 'GROUP_CHARACTER':
			token_type = 'GROUP_OPERATOR'
		elif token_type == 'COMMENT':
			return self.gettoken()
		elif token_type == 'SPACE':
			return self.gettoken()

		return token_type, token_val


class Dfa():
	STATES = {
		'INITIAL': 0,
		'IDENT': 1,
		'SPACE': 2,
		'NEWLINE': 3,
		'CHARACTER': 4,
		'NUMBER': 5,
		'COMMENT': 6,
		'STRING_SIMPLE_QUOTES': 7,
		'STRING_DOUBLE_QUOTES': 8,
		'STRING_SIMPLE_QUOTES_END': 9,
		'STRING_DOUBLE_QUOTES_END': 10,
		'NEGATIVE_SIGN': 11,
		'FLOAT_NUMBER': 12,
		'ESCAPING': 13,
		'CHARACTER_ESCAPED': 14,
		'CHARACTER_CAN_BE_FOLLOWED_BY_EQUAL': 15,
		'GROUP_CHARACTER': 16,
		'END': 999,
	}
	NONPRODUCTING_STATES = [
		STATES['ESCAPING'],
		STATES['CHARACTER_ESCAPED'],
	]

	def __init__(self, input_list):
		self.state = 0
		self.TRANSITIONS = {
			self.STATES['INITIAL']: [
				[is_negative_sign, self.STATES['NEGATIVE_SIGN']],
				[is_allowed_first_char_for_id, self.STATES['IDENT']],
				[is_space, self.STATES['SPACE']],
				[is_newline, self.STATES['NEWLINE']],
				[is_digit, self.STATES['NUMBER']],
				[is_character_can_be_followed_by_equal, self.STATES['CHARACTER_CAN_BE_FOLLOWED_BY_EQUAL']],
				[is_character, self.STATES['CHARACTER']],
				[is_hash, self.STATES['COMMENT']],
				[is_simple_quote, self.STATES['STRING_SIMPLE_QUOTES']],
				[is_double_quote, self.STATES['STRING_DOUBLE_QUOTES']],
				[anything, self.STATES['END']],
			],
			self.STATES['IDENT']: [
				[is_allowed_char_for_id, self.STATES['IDENT']],
				[is_not_allowed_char_for_id, self.STATES['END']],
			],
			self.STATES['SPACE']: [
				[is_space, self.STATES['SPACE']],
				[anything, self.STATES['END']],
			],
			self.STATES['NEWLINE']: [
				[is_tab, self.STATES['NEWLINE']],
				[anything, self.STATES['END']],
			],
			self.STATES['CHARACTER']: [
				[anything, self.STATES['END']],
			],
			self.STATES['NUMBER']: [
				[is_digit, self.STATES['NUMBER']],
				[is_point, self.STATES['FLOAT_NUMBER']],
				[anything, self.STATES['END']],
			],
			self.STATES['FLOAT_NUMBER']: [
				[is_digit, self.STATES['FLOAT_NUMBER']],
				[anything, self.STATES['END']],
			],
			self.STATES['COMMENT']: [
				[is_newline, self.STATES['END']],
				[anything, self.STATES['COMMENT']],
			],
			self.STATES['STRING_SIMPLE_QUOTES']: [
				[is_escape, self.STATES['ESCAPING']],
				[is_simple_quote, self.STATES['STRING_SIMPLE_QUOTES_END']],
				[anything, self.STATES['STRING_SIMPLE_QUOTES']]
			],
			self.STATES['STRING_SIMPLE_QUOTES_END']: [
				[anything, self.STATES['END']]
			],
			self.STATES['NEGATIVE_SIGN']: [
				[is_digit, self.STATES['NUMBER']],
				[anything, self.STATES['CHARACTER']],
			],
			self.STATES['ESCAPING']: [
				[is_escape, self.STATES['STRING_SIMPLE_QUOTES']],
				[is_simple_quote, self.STATES['STRING_SIMPLE_QUOTES']],
				[anything, self.STATES['CHARACTER_ESCAPED']],
			],
			self.STATES['CHARACTER_ESCAPED']: [
				[anything, self.STATES['STRING_SIMPLE_QUOTES']],
			],
			self.STATES['CHARACTER_CAN_BE_FOLLOWED_BY_EQUAL']: [
				[is_equal, self.STATES['GROUP_CHARACTER']],
				[anything, self.STATES['END']],
			],
			self.STATES['GROUP_CHARACTER']: [
				[anything, self.STATES['END']],
			],
		}
		self.position = 0
		self.input = input_list
		self.states = []
		self.output = []

	def consume(self):
		if self.position == len(self.input):
			exit(0)

		state = self.TRANSITIONS[self.state]
		for transition_function, transition_state in state:
			if transition_function(self.input[self.position]):
				self.states.append(self.state)
				if transition_state not in self.NONPRODUCTING_STATES:
					self.output.append(self.input[self.position])

				self.state = transition_state
				self.position += 1
				return
		raise Exception('No transition function')

	def run(self):
		while self.state != self.STATES['END']:
			self.consume()

		for key in self.STATES:
			if self.STATES[key] == self.states[-1]:
				return [''.join(self.output[:-1]), key, self.position-1]

	def transition(self, letter):
		pass


tokenizer = Tokenizer('python_lexical_analysis.py')
while True:
	token = tokenizer.gettoken()
	if not token:
		break
	print('{0: <16} => {1}'.format(*token))
