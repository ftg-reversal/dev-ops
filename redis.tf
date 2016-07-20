resource "aws_elasticache_cluster" "reversal_redis" {
    cluster_id = "reversal"
    engine = "redis"
    node_type = "cache.m3.medium"
    port = 6379
    num_cache_nodes = 1
    parameter_group_name = "default.redis2.8"
    subnet_group_name = "${aws_elasticache_subnet_group.reversal_redis_subnet.id}"
}
