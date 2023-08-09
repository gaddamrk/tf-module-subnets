resource "aws_subnet" "main" {
  count = length(var.cidr_block)
  cidr_block = var.cidr_block[count.index]
  vpc_id = var.vpc_id
  tags       = merge(
    local.common_tags,
    { Name = "${var.env}-${var.name}-subnet-${count.index+1}" }
  )

}

resource "aws_route_table" "example" {
  vpc_id = var.vpc_id

  route {
    cidr_block                = data.aws_vpc.default.cidr_block
    vpc_peering_connection_id = var.vpc_peering_connection_id
  }

  tags       = merge(
    local.common_tags,
    { Name = "${var.env}-${var.name}-route_table" }
  )


}



