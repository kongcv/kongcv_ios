//
//  ZHXDataCenter.m
//  kongcv
//
//  Created by 空车位 on 15/12/24.
//  Copyright © 2015年 空车位. All rights reserved.
//

#import "ZHXDataCenter.h"
#import "FMDatabase.h"

@interface ZHXDataCenter ()

@property (nonatomic,strong) FMDatabase *database;
@end

@implementation ZHXDataCenter


static ZHXDataCenter *dataCenter = nil;
+(ZHXDataCenter *)sharedCenter{

    @synchronized(self){
    
        dataCenter = [[ZHXDataCenter alloc]init];
    }
    return dataCenter;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{

    @synchronized(self){
        if (!dataCenter) {
            dataCenter = [super allocWithZone:zone];
        }
    }
    return dataCenter;
}

- (id)init{
    if (self = [super init]) {
        
        [self createDataBase];
    }
    return self;
}

- (void)createDataBase{

    //创建数据库路径
    NSString *path = [NSString stringWithFormat:@"%@/Documents/data.db",NSHomeDirectory()];
    //创建数据库
    _database = [[FMDatabase alloc]initWithPath:path];
    
    if ([_database open]) {
        NSLog(@"打开成功");
    }else{
        return;
    }
    NSString *sql = @"create table if not exists applist("
    " id integer primary key autoincrement not null, "
    " collection varchar(32), "
    " objectId varchar(64), "
    " city varchar(32), "
    " address varchar(32), "
    " gate_card varchar(1024), "
    " park_height varchar(32), "
    " park_space varchar(32), "
    " kStruct varchar(32) "
    ");";
    
    BOOL b = [self.database executeUpdate:sql];
    if (b) {
        NSLog(@"成功创建表格");
    }
}


//增加数据
- (BOOL)addDataWithModel:(DetailInfoModel *)model andType:(Collection)type{
    
    NSString *sql = @"insert into applist(collection,objectId,city,address,gate_card,park_height,park_space,kStruct) values(?,?,?,?,?,?,?,?)";
    
    BOOL b = [self.database executeUpdate:sql,[NSString stringWithFormat:@"%i",type],model.objectId,model.city, model.address  , model.gate_card , model.park_height , model.park_space , model.park_struct];
    
    return b;
}

//删除数据
- (BOOL)deleteDataWithModel:(DetailInfoModel *)model andType:(Collection)type{

    NSString *sql = @"delete from applist where objectId=? and collection=?";
    BOOL b = [self.database executeUpdate:sql,model.objectId, [NSString stringWithFormat:@"%i",type]];
    
    return b;
}

//查找数据
- (BOOL)findDataWithModel:(DetailInfoModel *)model andType:(Collection)type{

    NSString *sql = @"select count(*) from applist where objectId=? and collection=?";
    
    FMResultSet *set = [self.database executeQuery:sql,model.objectId, [NSString stringWithFormat:@"%i",type]];
    
    int count = 0;
    
    if ([set next]) {
        count = [set intForColumnIndex:0];
    }
    
    return count;
}

- (NSArray *)getData:(Collection )type{
    
    NSString *sql = @"select * from applist where collection=?";
    
    FMResultSet *set = [self.database executeQuery:sql,[NSString stringWithFormat:@"%i",type]];
    
    NSMutableArray *array = [NSMutableArray array];
    
    while ([set next]) {
        DetailInfoModel *model = [[DetailInfoModel alloc]init];
        model.objectId  = [set stringForColumn:@"objectId"];
        model.city = [set stringForColumn:@"city"];
        model.address = [set stringForColumn:@"address"];
        model.park_height = [set stringForColumn:@"park_height"];
        model.gate_card = [set stringForColumn:@"gate_card"];
        model.park_space = [set stringForColumn:@"park_space"];
        model.park_struct = [set stringForColumn:@"kStruct"];

        [array addObject:model];
    }
    
    return array;
}

@end














