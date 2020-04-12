variable "default_tags" {
  type = map
  default = {
    contact : "email",
    Name : "Value",
    department : "dept_name",
    environment = "dev"
    live        = "no"
  }
}
