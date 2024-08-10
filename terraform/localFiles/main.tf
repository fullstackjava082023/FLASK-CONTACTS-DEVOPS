resource "local_file" "foo" {
  content  = "foo!"
  filename = "${path.module}/foo.bar"
}

resource "random_pet" "mypet2" {
  prefix = "mr"
  separator = "."
  length = "1"
}

resource "local_file" "mypetfile" {
  content  = "This is my pet: ${random_pet.mypet2.id}!"
  filename = "${path.module}/mypet.txt"
}
