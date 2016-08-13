resource "aws_elasticache_cluster" "redis" {
    cluster_id = "reversal-redis"
    engine = "redis"
    port = "6379"
    node_type = "cache.t2.micro"
    num_cache_nodes = "1"
    parameter_group_name = "default.redis2.8"
    security_group_ids = ["${aws_security_group.store_security_group.id}"]
    subnet_group_name = "${aws_elasticache_subnet_group.redis_subnet.name}"
}

resource "aws_elasticache_subnet_group" "redis_subnet" {
    name = "redis-subnet"
    description = "redis subnet"
    subnet_ids = ["${aws_subnet.reversal_redis.id}"]
}
