//
//  URL_header.h
//  原油期货宝
//
//  Created by 尚朋 on 16/7/19.
//  Copyright © 2016年 jnhyxx. All rights reserved.
//

#ifndef URL_header_h
#define URL_header_h



//域名
#define RootURL @"http://www.jnhyxx.com"

//文档版本
#define Version @"1.0.0"



#pragma mark ------------------账户界面-----------------

//注册
#define RegisterURL  [NSString stringWithFormat:@"%@/user/register",RootURL]


/**注册验证码获取*/
#define RegCode [NSString stringWithFormat:@"%@/user/sms/getRegCode",RootURL]
/**注册短信验证码验证*/
#define authRegCode  [NSString stringWithFormat:@"%@user/sms/authRegCode",RootURL]


/**登陆*/
#define LoginURL  [NSString stringWithFormat:@"%@/user/login",RootURL]

/**个人持仓 /order/order/currentOrderList  现金 积分 订单*/
#define currentOrderList  [NSString stringWithFormat:@"%@/order/order/currentOrderList",RootURL]

///user/sms/findLoginPwdCode 获取找回登录密码验证码
#define findLoginPwdCode [NSString stringWithFormat:@"%@/user/sms/findLoginPwdCode",RootURL]
// /user/sms/authLoginPwdCode  找回登录密码验证码验证
#define authLoginPwdCode [NSString stringWithFormat:@"%@/user/sms/authLoginPwdCode",RootURL]
//找回登录密码-修改登录密码  /user/user/findLoginPwd
#define findLoginPwd [NSString stringWithFormat:@"%@/user/user/findLoginPwd",RootURL]



///sms/message/systemMessages 系统消息列表
#define systemMessages [NSString stringWithFormat:@"%@/sms/message/systemMessages",RootURL]
// 交易消息列表 


//积分交易记录-已结算
#define ScoreOrderList [NSString stringWithFormat:@"%@/financy/financy/apiScoreFinancyFlowList",RootURL]
//资金流水列表  /financy/financy/apiFinancyFlowList
#define  FinancyFlowList [NSString stringWithFormat:@"%@/financy/financy/apiFinancyFlowList",RootURL]
//用户资金账户  /financy/financy/apiFinancyMain
#define FinancyMain [NSString stringWithFormat:@"%@/financy/financy/apiFinancyMain",RootURL]


#pragma mark -- 信息页

//最新接口/user/user/getAcountDetail
#define AcountDetail [NSString stringWithFormat:@"%@/user/user/getAcountDetail",RootURL]



//验证是否实名认证 /user/user/checkUserName
#define checkUserName [NSString stringWithFormat:@"%@/user/user/checkUserName",RootURL]
//实名认证 /user/user/authUser
#define authUser [NSString stringWithFormat:@"%@/user/user/authUser",RootURL]

//验证银行卡是否绑定 /user/user/checkBankCard
#define checkBankCard [NSString stringWithFormat:@"%@/user/user/checkBankCard",RootURL]

//绑定银行卡 /user/user/bindBank  /user/user/updatebank

#define bindBank [NSString stringWithFormat:@"%@/user/user/updatebank",RootURL]

//验证手机号是否绑定  /user/user/checkTele
#define checkTele [NSString stringWithFormat:@"%@/user/user/checkTele",RootURL]

//绑定手机 /user/user/bindTele
#define bindTele [NSString stringWithFormat:@"%@/user/user/bindTele",RootURL]

//验证昵称是否修改过 /user/user/checkNickChange
#define checkNickChange [NSString stringWithFormat:@"%@/user/user/checkNickChange",RootURL]

//修改昵称 /user/user/updUserNick
#define updUserNick [NSString stringWithFormat:@"%@/user/user/updUserNick",RootURL]


//根据银行卡号查询银行名称  /user/user/findBankName


#pragma mark -- 提现

//返回用户的当前可提现金额  /financy/financy/ getWithdraw

//查看用户提现记录  /financy/financy/getWithdrawHistory

//查看用户提现记录详情 /financy/financy/getWithdrawHistoryDetail

//提现撤销  /financy/financy/cancleWithdraw


#pragma mark -- 推广页

//判断是否推广员 /promotion/getPromoteStatus

//推广员推广详细  /promotion/getPromoteDetail


//推广员下线详细 /promotion/getPromoteSubUsers

//查询佣金转现申请记录 /commissions/getCommissionsToCashHistory  //xx


#pragma mark ------------------账户界面END-----------------




#endif /* URL_header_h */
