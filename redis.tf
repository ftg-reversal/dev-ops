resource "aws_elasticache_cluster" "redis" {
    cluster_id = "reversal-redis"
    engine = "redis"
    port = 6379
    node_type = "cache.t2.micro"
    num_cache_nodes = 1
    parameter_group_name = "default.redis2.8"
    subnet_group_name = "${aws_subnet.reversal_public_webserver.id}"
}
