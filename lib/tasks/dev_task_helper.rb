# frozen_string_literal: true
def fakeup(desc)
  print desc
  yield
  puts :完成
end
