package com.zhongxin.cims.common.config;

/**
 * Created by caill on 2014/7/8.
 */


public final class Constants
{
    public final static String GLOBAL_DELETE_TYPE="7";
    public final static String GLOBAL_UPDATE_TYPE="2";
    public final static String GLOBAL_SO_REMOVE_STS ="7";
    public final static String GLOBAL_SO_COMMIT_STS ="1";
    public final static String GLOBAL_CP_APP_ID="CP"; // 三类人员
    public final static String GLOBAL_AC_APP_ID="AC"; // 建造师
    public final static String GLOBAL_EQ_APP_ID="EQ"; // 企业资质
    public final static String GLOBAL_SE_APP_ID="SE"; // 安全许可
    public final static String GLOBAL_SO_TYPE_SO="01";
    public final static String GLOBAL_SO_TYPE_EXTEND="08";
    public final static String GLOBAL_SO_TYPE_CHANGE="02";
    public final static String GLOBAL_SO_TYPE_REMOVE="04";

    public final static String GLOBAL_CERT_STS_COMMIT="1";
    public final static String GLOBAL_CERT_STS_REMOVE="2";
    public final static String GLOBAL_CERT_STS_COMPLETE="0";
    public final static String GLOBAL_SO_CP_UPLOAD_STS_COMMIT="0";
    public final static String GLOBAL_SO_CP_TITLE_PAGE_MODULE="cpTitleForm";
    public final static String GLOBAL_SO_CP_BASE_PAGE_MODULE="cpBaseForm";
    public final static String GLOBAL_SO_CP_RESUME_PAGE_MODULE="cpResumeForm";
    public final static String GLOBAL_SO_CP_PERFORMANCE_PAGE_MODULE="cpPerformanceForm";
    public final static String GLOBAL_SO_CP_APPROVE_PAGE_MODULE="cpApprForm";

    public final static String BACK_ACTIVITY_START = "1";// 回退到企业
    public final static String BACK_ACTIVITY_PRE = "0";// 回退到上一环节

    public final static String SO_STS_FINISH = "0"; // 竣工
    public final static String SO_STS_COMMIT = "1"; // 提交
    public final static String SO_STS_RECIVED = "2"; // 已接收
    public final static String SO_STS_AUDITING = "3"; //审核中
    public final static String SO_STS_AUDITED = "4";//审核完成
    public final static String SO_STS_CANCLING = "5"; // 撤销中
    public final static String SO_STS_CANCLED = "6";  // 撤销完成
    public final static String SO_STS_REMOVE = "1";   // 作废
    public final static String SO_STS_BACK = "8";   // 退回
    public final static String SO_STS_SAVE = "9";   // 初始保存
    public final static String SERV_STS_NOMAL = "0"; // 正常
    public final static String SERV_STS_REMOVE = "1"; // 失效状态

    public final static String SYS_BATCH_STS_COMMIT ="1"; //提交
    public final static String SYS_BATCH_STS_LOCK ="2"; //锁定
    public final static String SYS_BATCH_STS_UNLOCK="3";//解锁
    public final static String SYS_BATCH_STS_REMOVE ="4";//作废
    public final static String SYS_BATCH_STS_USED="0";//已使用
    public final static String  SYS_BATCH_BEGIN_SEQ="1001";//初始序号

    public final static String SO_APPR_ASS_STS_COMP = "02"; // 企业
    public final static String SO_APPR_ASS_STS_LOC = "01"; // 盟市
    public final static String SO_APPR_ASS_STS_MOGON = "00"; // 厅

    public final static String CHECK_MSG_SO_COMPLETE_BEFORE="存在在途申报，未完成前不允许再次申报!";
    public final static String CHECK_MSG_SERV_SAME_BEFORE="存在已申报信息，不允许再次申报，请注销后再申报!";

    public final static String IS_PAY_FEE_STATE ="1";//已支付
    public final static String NO_PAY_FEE_STATE ="0";//未支付

    public final static String IS_LEARN_STATE_COMMIT="0";
    public final static String IS_HOUR_STATE_COMMIT ="0";
    public final static String IS_EXAM_STATE_COMMIT="0";
    public final static String IS_CERT_STATE_COMMIT ="0";
    public final static String IS_REDUCE_FLAG_COMMIT ="0";

    public final static String PLAN_STS_COMMIT ="2"; //待审核
    public final static String PLAN_STS_REMOVE ="1"; //审核不通过、作废
    public final static String PLAN_STS_AUDITED ="0"; //审核通过
    public final static String PLAN_NAME_CONCAT="专业二级建造师继续教育培训-";

    public final static String ALIPAY_RSP_CODE_SUCESS="TRADE_SUCCESS";

    public final static String LEARN_HOURS_TYPE_REDUCE="0";//减免学时
    public final static String LEARN_HOURS_TYPE_LESSON="1";//课程学时
    public final static String LEARN_HOURS_AUDIT_COMMIT="0";//待审核
    public final static String LEARN_HOURS_AUDIT_PASSED="1";//审核通过
    public final static String LEARN_HOURS_AUDIT_NOPASSED="2";//审核不通过

    public final static String EXAM_AUDIT_COMMIT="0";//待审核
    public final static String EXAM_AUDIT_PASSED="1";//审核通过
    public final static String EXAM_AUDIT_NOPASSED="2";//审核不通过
    public final static String EXAM_AUDIT_TYPE_AGAIN="1";//补考
    public final static String EXAM_AUDIT_TYPE_NOMAL="0";//正常考试

    public final static String IMAGE_TYPE ="image/png";
    public final static String IMAGE_STS_COMMMIT="1";//提交状态
    public final static String IMAGE_STS_REMOVE="7";//审核不通过状态 作废状态
    public final static String IMAGE_STS_AUDIT="2";//待审核状态
    public final static String IMAGE_STS_CONFIRMED="3";//待确认状态
    public final static String IMAGE_STS_NOMAL="0";//审核通过状态 有效状态

    public final static String HOURS_STS_COMMMIT="1";//提交状态
    public final static String HOURS_STS_REMOVE="7";//审核不通过状态 作废状态
    public final static String HOURS_STS_AUDIT="2";//待审核状态
    public final static String HOURS_STS_NOMAL="0";//审核通过状态 有效状态


    public final static String SO_TYPE_REDUCE_HOURS = "reduceHours";
    public final static String SO_TYPE_LESSON_HOURS = "lessonId";

    public final static String AUDIT_LEVEL_FIRST = "0"; // 审核环节:初审
    public final static String AUDIT_LEVEL_SECOND = "1"; // 审核环节:复审
    public final static String AUDIT_LEVEL_THIRD = "2"; // 审核环节:终审
    public final static String AUDIT_LEVEL_COMPLETE = "3"; // 审核环节:完成

    public final static String AUDIT_TYPE_INVOCE = "0"; // 审核类型:发票审核
    public final static String AUDIT_TYPE_REDUCE = "1"; // 审核类型:减免学时审核
    public final static String AUDIT_TYPE_HOURS = "2"; // 审核类型:学时审核
    public final static String AUDIT_TYPE_EXAM = "3"; // 审核类型:考试审核

    public final static String AUDIT_USER_LIST = "nmjx,nmjx3"; // 需要使用加密狗的用户，逗号分隔
}