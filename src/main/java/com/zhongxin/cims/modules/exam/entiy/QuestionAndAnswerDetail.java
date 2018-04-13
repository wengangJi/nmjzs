package com.zhongxin.cims.modules.exam.entiy;

import com.zhongxin.cims.common.persistence.BaseEntity;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: lining
 * Date: 2014/8/30
 * Time: 22:49
 * To change this template use File | Settings | File Templates.
 */

public class QuestionAndAnswerDetail extends BaseEntity<QuestionAndAnswerDetail> {

    private  int questionId;

    private  String questionChoice;

    private String index;

    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIndex() {
        return index;
    }

    public void setIndex(String index) {
        this.index = index;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getQuestionChoice() {
        return questionChoice;
    }

    public void setQuestionChoice(String questionChoice) {
        this.questionChoice = questionChoice;
    }
}
