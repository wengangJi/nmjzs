package com.zhongxin.cims.modules.exam.entiy;

import com.zhongxin.cims.common.persistence.BaseEntity;

/**
 * Created with IntelliJ IDEA.
 * User: lining
 * Date: 2014/8/30
 * Time: 12:07
 * To change this template use File | Settings | File Templates.
 */

public class ExaminationChoice extends BaseEntity<ExaminationChoice> {
    private  String questionTotals;
    private  String type;
    private  String profession;
    private  String questionTime;

    public String getQuestionTime() {
        return questionTime;
    }

    public void setQuestionTime(String questionTime) {
        this.questionTime = questionTime;
    }

    public String getQuestionTotals() {
        return questionTotals;
    }

    public void setQuestionTotals(String questionTotals) {

        this.questionTotals = questionTotals;
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
}
