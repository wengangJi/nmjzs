package com.zhongxin.cims.modules.exam.entiy;

import com.zhongxin.cims.common.persistence.BaseEntity;

/**
 * Created with IntelliJ IDEA.
 * User: lining
 * Date: 2014/9/2
 * Time: 11:10
 * To change this template use File | Settings | File Templates.
 */

public class AnswerDetail extends BaseEntity<AnswerDetail> {
    private  int questionId;

    private  String answer;

    private  int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }
}
