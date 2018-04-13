package com.zhongxin.cims.modules.exam.entiy;

import com.zhongxin.cims.common.persistence.BaseEntity;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: lining
 * Date: 2014/8/30
 * Time: 22:54
 * To change this template use File | Settings | File Templates.
 */

public class ExamInfoDetail extends BaseEntity<ExamInfoDetail> {
    private   int  id;
    private   int examinfoId;
    private   int questionId;
    private   String userAnswer;
    private   String  isCorrect;
    private   String userId;
    private   String userName;
    private String soId;
    private String sts;
    private Date stsDate;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getExaminfoId() {
        return examinfoId;
    }

    public void setExaminfoId(int examinfoId) {
        this.examinfoId = examinfoId;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getUserAnswer() {
        return userAnswer;
    }

    public void setUserAnswer(String userAnswer) {
        this.userAnswer = userAnswer;
    }

    public String getIsCorrect() {
        return isCorrect;
    }

    public void setIsCorrect(String isCorrect) {
        this.isCorrect = isCorrect;
    }

    public String getSoId() {
        return soId;
    }

    public void setSoId(String soId) {
        this.soId = soId;
    }

    public String getSts() {
        return sts;
    }

    public void setSts(String sts) {
        this.sts = sts;
    }

    public Date getStsDate() {
        return stsDate;
    }

    public void setStsDate(Date stsDate) {
        this.stsDate = stsDate;
    }
}
