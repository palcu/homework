from collections import defaultdict
from pprint import pprint

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


MAX_SALI = 5
NO_SALI = 3

def get_next_movie(time, movies):
  low = 0
  high = len(movies) - 1
  mid = 0
  while low <= high:
    mid = (low+high) / 2
    if movies[mid]['start'] > time:
      high = mid - 1
    elif movies[mid]['start'] < time:
      low = mid + 1
    else: return movies[mid]
  if movies[mid]['start'] > time: return movies[mid]
  return -1

def solveC(movies, dist_sali):
  # salile au o distanta intre ele, cat de multe filme poti vedea
  # d[i][j] va reprezenta cate filme am putut vedea, avand in
  # vedere ca ma aflu la al i-lea film vazut si sunt in sala j
  # stiu ca atunci cand merg dintr-o sala in alta, ma duc la primul film la
  # care pot ajunge, pentru ca nu se suprapun (pot face cautare binara)
  # in time[i][j], tin timpul la care se termina ultimul film

  time = [[0 for x in range(MAX_SALI)] for x in range(MAX_SALI)]
  no_of_movies = [[0 for x in range(MAX_SALI)] for x in range(MAX_SALI)]
  sali = [[] for x in range(NO_SALI + 1)]

  for movie in movies:
    sali[movie['room']].append(movie)

  for no_sala in range(1, NO_SALI + 1):
    time[1][no_sala] = sali[no_sala][0]['end']
    no_of_movies[1][no_sala] = 1
    sali[no_sala].sort(key=lambda x: x['start'])

  # pprint(time)
  # pprint(no_of_movies)
  # pprint(dist_sali[1][1])
  filmul_la_care_am_ajuns = 1
  sali_din_care_pot_inca_pleca = range(1, NO_SALI)
  # get_next_movie(2, sali[3])
  import ipdb; ipdb.set_trace()
  while len(sali_din_care_pot_inca_pleca):
    filmul_la_care_am_ajuns += 1
    for sala_in_care_pot_ajunge in range(1, NO_SALI):
      for sala in sali_din_care_pot_inca_pleca:
        cost = 0  if sala == sala_in_care_pot_ajunge else dist_sali[sala][sala_in_care_pot_ajunge]
        timpul_la_care_ajung = time[filmul_la_care_am_ajuns-1][sala_in_care_pot_ajunge] + cost
        get_next_movie(timpul_la_care_ajung,   # pot renunta frumos la matrice pt timp
                       sali[sala_in_care_pot_ajunge])
        if get_next_movie != -1:
          if time[filmul_la_care_am_ajuns][sala_in_care_pot_ajunge]






with open('movies.in') as stream:
  lines = [x.split() for x in stream.readlines()]
  movies = [{'room': int(x[0]),
             'start': int(x[1]),
             'end': int(x[2])} for x in lines]

  # print solveA(movies)
  # print solveB(movies)

  with open('sali.in') as stream_sali:
    lines = [x.split() for x in stream_sali.readlines()]
    sali = [[0 for x in range(MAX_SALI)] for x in range(MAX_SALI)]
    for sala in lines:
      sali[int(sala[0])][int(sala[1])] = int(sala[2])
    # print(sali)
    solveC(movies, sali)
