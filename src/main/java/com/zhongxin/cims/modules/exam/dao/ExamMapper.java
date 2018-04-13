/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.zhongxin.cims.modules.exam.dao;

import com.zhongxin.cims.common.persistence.BaseDao;
import com.zhongxin.cims.common.persistence.annotation.MyBatisDao;
import com.zhongxin.cims.modules.ac.entity.SoPlan;
import com.zhongxin.cims.modules.cp.entity.Personnel;
import com.zhongxin.cims.modules.exam.entiy.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 考试DAO接口
 * @author ln
 * @version 2014-08-29
 */
@MyBatisDao
public interface ExamMapper {
    public	List<Question> getQuestionList(Question question);
    public	List<Question> getQuestionListById(List listItem);
    public int addExamInfo(ExamInfo examInfo);
    public int addExamInfoAgain(ExamInfo examInfo);

    public int addExamInfoDetail(ExamInfoDetail examInfoDetail);
    public int getExamInfoId(String userName);
    public int getExamInfoIdAgain(String userName);
    public String getAnswerByQuestionId(int questionId);
    public List<AnswerDetail>  getAnswer(int questionId);
    public List<ExamInfoDetail>getExamDetailInfoList(Map map);
    public int addQuestionSub(QuestionAndAnswerDetail questionAndAnswerDetail);
    int addQuestionLib(Question question);
    public int  addAnswer(AnswerDetail answer);
    public int getQuestionId();
    public int getAnswerId();
    public int getSubQuestionId();
    public  List getCoresByUserName(String userName);
    public  List getCoresByUserId(String userId);
    public int getCoresByExamId(Map map);
    public int getCoresByExamIdAgain(Map map);

    public List<Integer> getMyexamQuestionId(int examInfoId);
    public	List<Question> getQuestionListByType(Map map);
    public	List<Question> getQuestionListByTypeAgain(Map map);

    public void deleteQuestionById(int questionId);
    public void updQuestionById(Map map);
    public void updQuestionChoiceById(Map map);
    public void deleteQuestionBySubId(int questionId);
    public void deleteAnswerByQuestionId(int questionId);
    public List<HashMap<String,String>> getCoresByExamInfoId(Map map);
    public void updExamInfoCores(Map map);
    public void updExamInfoCoresAgain(Map map);

    public void updExamInfoCheckLevel(Map map);
    public List<Integer> getIdFromQuestionLib(@Param("majorId") String majorId,@Param("QuestionStyle") String QuestionStyle);
    public List<HashMap<String,String>> getCountByQuestionType();
    public List getQuestionNumberList();
    public int findResultCountBySoid(String soid);
    public int findAgainResultCountBySoid(String soid);
    public int findCountBySoid(String soid);
    public List<ExamInfo> getSoExamInfoByUser(String userId);
    public List<ExamInfo> getSoExamInfo(SoPlan soPlan);
    public List<ExamInfo> findAuditExamList(ExamInfo examInfo);
    public List<ExamInfo> findHisAuditExamList(ExamInfo examInfo);

    int updateByPrimaryKeySelective(ExamInfo record);
    int updExamInfoAgain(Map map);
    int updateAgainByPrimaryKeySelective(ExamInfo record);
    public ExamInfo selectByPrimaryKey(Long id);
    public ExamInfo selectAgainByPrimaryKey(Long id);

}
