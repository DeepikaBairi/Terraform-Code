resource aws_db_instance "deepikab"{
    allocated_storage = 20
    engine = "MySQL"
    engine_version = "8.0.23"
    instance_class = "db.t2.micro" 
    name = "deepikab"
    username ="deepikab"
    password = "deepikab"
    allow_major_version_upgrade = null
    auto_minor_version_upgrade = true
    availability_zone = "ap-southeast-1c"
    multi_az = false
    vpc_security_group_ids = ["sg-0cab80426ca7b6829"]
}
