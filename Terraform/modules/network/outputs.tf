output "vpc_id" {
  value = aws_vpc.vpc1.id
}

output "public_subnet_2a_id" {
  value = aws_subnet.public_2a.id
}

output "public_subnet_2c_id" {
  value = aws_subnet.public_2c.id
}

output "private_subnet_2a_id" {
  value = aws_subnet.private_2a.id
}

output "private_subnet_2c_id" {
  value = aws_subnet.private_2c.id
}

output "private_route_table_id" {
  value = aws_route_table.private_rt.id
}