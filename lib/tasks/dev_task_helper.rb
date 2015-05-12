def fakeup desc
  print desc
  yield
  puts :完成
end