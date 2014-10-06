# Datele de intrare sunt de forma (sala, start, finish)

def solveA(movies):
  # nr. maxim de showuri pe care le poate vedea
  movies.sort(key=lambda x: x['end'])

  sol = 0
  last_end_time = -1
  for movie in movies:
    if last_end_time <= movie['start']:
      sol += 1
      last_end_time = movie['end']
  return sol


def solveB(movies):
  # nr. maxim de filme in acelasi timp
  # solutia in care avem mai putine evenimente, decat timpul disponibil
  events = []
  for movie in movies:
    events.append([movie['start'], 'start'])
    events.append([movie['end'], 'end'])

  events.sort(key=lambda x: x[0])
  sol = 0
  current_running_shows = 0
  for event in events:
    if event[1] == 'start':
      current_running_shows += 1
    else:
      current_running_shows -= 1
    sol = max(sol, current_running_shows)

  return sol


def solveC(movies, sali):
  pass


with open('movies.in') as stream:
  lines = [x.split() for x in stream.readlines()]
  movies = [{'room': int(x[0]),
             'start': int(x[1]),
             'end': int(x[2])} for x in lines]

  # print solveA(movies)
  # print solveB(movies)

  with open('sali.in') as stream_sali:
    MAX_SALI = 5
    lines = [x.split() for x in stream_sali.readlines()]
    sali = [[0 for x in range(MAX_SALI)] for x in range(MAX_SALI)]
    for sala in lines:
      sali[int(sala[0])][int(sala[1])] = int(sala[2])
    solveC(movies, sali)
