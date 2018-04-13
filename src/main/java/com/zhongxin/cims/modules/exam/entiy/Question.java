package com.zhongxin.cims.modules.exam.entiy;

import com.zhongxin.cims.common.persistence.BaseEntity;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: lining
 * Date: 2014/8/30
 * Time: 16:56
 * To change this template use File | Settings | File Templates.
 */

public class Question extends BaseEntity<Question> {
    private   int  id;
    private   String question;
    private   List<AnswerDetail> answer;
    private   String  QuestionStyle;
    private   String delFlag;
    private   String type;
    private   String profession;
    private   List<QuestionAndAnswerDetail> detail;
    private   String userAnswer;

    private  String trueFlag;

    public String getTrueFlag() {
        return trueFlag;
    }

    public void setTrueFlag(String trueFlag) {
        this.trueFlag = trueFlag;
    }

    public String getUserAnswer() {
        return userAnswer;
    }

    public void setUserAnswer(String userAnswer) {
        this.userAnswer = userAnswer;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public List<AnswerDetail> getAnswer() {
        return answer;
    }

    public void setAnswer(List<AnswerDetail> answer) {
        this.answer = answer;
    }

    public String getQuestionStyle() {
        return QuestionStyle;
    }

    public void setQuestionStyle(String questionStyle) {
        QuestionStyle = questionStyle;
    }

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getProfession() {
        return profession;
    }

    public void setProfession(String profession) {
        this.profession = profession;
    }

    public List<QuestionAndAnswerDetail> getDetail() {
        return detail;
    }

    public void setDetail(List<QuestionAndAnswerDetail> detail) {
        this.detail = detail;
    }
}
