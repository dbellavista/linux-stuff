import subprocess

def iter_lines(cmd, wait_on_exit=True):
  """Generator for iterate line of a process output

  Keyword arguments:
  cmd -- The command to execute
  wait_on_exit -- wait the process on EOF (default True)
  """

  process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
  for l in iter(process.stdout.readline, b''):
    yield l
  if wait_on_exit:
    process.wait()

def recvtill(s, target, count=1):
  """Receive data from the socket s until count occurence of target are in the buffer.
  Then it returns the buffer.

  Keyword arguments:
  s -- The socket to use
  target -- The target string
  count -- The number of occurrence of result needed (default 1)
  """
  done = False
  buf = ''
  while not done:
    r = s.recv(1000)
    if not r:
      return buf
    buf += r
    done = buf.count(target) == count
  return buf
