#SageMath version 8.8, Python 2.7.15
# coding: utf-8

#./sage ./code_uni/lab2.sage

from copy import copy

def init_func():
	a, b, p = map(int, raw_input('Print a, b, p\n').split(' '))
	return a, b, p

def init_point():
	print('Print point P')
	P = [int(input('P[x] = ')), int(input('P[y] = '))]
	return P

def check_input_point(P, a, b, p):	
	try:
		check_input_point(P, a, b, p)
	except:
		message = ['Please, try one more time','Your point is not on a curve given']
		print('\n'.join(message))
		P = init_point()
		check_input_point(P, a, b, p)
	else:
		return P

def check_input_point(P, a, b, p):
	assert (P[1]**2) % p == (P[0]**3 +a*P[0]+b) % p

def init_pass():
	print('Print numbers of Alice and Bob')
	A = int(input('Alice number is '))
	B = int(input('Bob number is '))
	return A, B

def gen_key(a, b, p, A, B, P):
	K1 = powP(P, A, a, b, p)
	K2 = powP(P, B,a, b, p)
	key = powP(K1, B, a, b, p)

	return key


def addP(P, Q, a, b, p):
	if P == []:
		if Q[1] == 0:
			R = Q
		else:
			R = [Q[0], -Q[1] % p]
	elif Q == []:
		if P[1] == 0:
			R = P
		else:
			R = [P[0], -P[1] % p]
	elif Q == P:
		if Q[1] == 0:
			R = []
		else:
			s = ((((3*P[0]**2) % p + a) % p)/((2*P[1])%p)) % p
			R = [(s**2 - P[0] - Q[0])%p]
			R.append((-1*(P[1]+s*(R[0]-P[0])))%p)
	elif Q != P:
		if Q[0] == P[0]:
			R = []
		else:
			s = (((Q[1]-P[1])%p)/((Q[0]-P[0])%p))%p
			R = [(s**2 - P[0] - Q[0])%p]
			R.append((-1*(P[1]+s*(R[0]-P[0])))%p)
	else:
		print('Bug')

	return R

def powP(P, k, a, b, p):
	R = copy(P)
	for i in range(k-1):
		R = addP(R, P, a, b, p)

	return R

def main():
	a, b, p = init_func()
	P = init_point()
	A, B = init_pass()
	key = gen_key(a, b, p, A, B, P)
	
	print(key)


if __name__ == '__main__':
	main()