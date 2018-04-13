package com.zhongxin.cims.modules.common.web;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.mapper.BeanCopierMapper;
import com.zhongxin.cims.common.mapper.BeanMapper;
import com.zhongxin.cims.common.mapper.JsonMapper;
import com.zhongxin.cims.common.persistence.Page;
import com.zhongxin.cims.common.utils.DateUtils;
import com.zhongxin.cims.common.utils.StringUtils;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.ac.dao.ServAssociateConstructorMapper;
import com.zhongxin.cims.modules.ac.entity.ServAssociateConstructor;
import com.zhongxin.cims.modules.ac.entity.SoPlan;
import com.zhongxin.cims.modules.ac.service.PlanService;
import com.zhongxin.cims.modules.ac.service.ServAssociateConstructorService;
import com.zhongxin.cims.modules.common.dao.CertMapper;
import com.zhongxin.cims.modules.common.dao.PrintTemplateMapper;
import com.zhongxin.cims.modules.common.dao.SoMapper;
import com.zhongxin.cims.modules.common.entity.Cert;
import com.zhongxin.cims.modules.common.entity.PrintTemplate;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.common.entity.SoMainCert;
import com.zhongxin.cims.modules.common.service.CertService;
import com.zhongxin.cims.modules.common.service.PrintService;
import com.zhongxin.cims.modules.cp.entity.Personnel;
import com.zhongxin.cims.modules.cp.entity.ServCpEntity;
import com.zhongxin.cims.modules.cp.entity.SoCpBase;
import com.zhongxin.cims.modules.cp.entity.SoCpEntity;
import com.zhongxin.cims.modules.cp.service.SoCpService;
import com.zhongxin.cims.modules.sys.dao.TagMapper;
import com.zhongxin.cims.modules.sys.utils.DictUtils;
import com.zhongxin.cims.modules.sys.utils.TagUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;


@Controller
@RequestMapping(value = "${adminPath}/print")
public class PrintController extends BaseController {

    private String filePrintDirectory = Global.getPrintDir();


    @Autowired
    private ServAssociateConstructorMapper servAssociateConstructorMapper;

    @Autowired
    private PlanService planService;

    @Autowired
    private SoCpService soCpService;

    @Autowired
    private CertService certService;

    @Autowired
    private SoMapper soMapper;

    @Autowired
    private TagMapper tagMapper;

    @Autowired
    private PrintTemplateMapper printTemplateMapper;

    @Autowired
    private PrintService printService;

    @Autowired
    private CertMapper certMapper;

    @ModelAttribute
    public PrintTemplate get(@RequestParam(required=false) String id) {
        if (StringUtils.isNotBlank(id)){
            return printTemplateMapper.selectByPrimaryKey(new Long(id));
        }else{
            return new PrintTemplate();
        }
    }

    @RequestMapping(value = "")
    public String index(HttpServletRequest request, HttpServletResponse response) {
        return "modules/print/Print";
    }

    @RequestMapping(value = "save")
    public String save(PrintTemplate printTemplate,HttpServletRequest request, HttpServletResponse response) {
        printTemplate.setSoType("01");
        printTemplate.setCertType("AC");
        printService.save(printTemplate);
        return "modules/print/printTemplateList";
    }

    @RequestMapping(value = "delete")
    public String delete(String id,HttpServletRequest request, HttpServletResponse response) {
        printService.delete(id);
        return "modules/print/printTemplateList";
    }

    @RequestMapping(value = "form")
    public String form(PrintTemplate printTemplate,Model model) {
        return "modules/print/printTemplateForm";
    }

    @RequestMapping(value = "addElem")
    public String addElem(PrintTemplate printTemplate,String certType,String soType,String pageNum,String indexItem,Model model) {
        printTemplate.setCertType(certType);
        printTemplate.setSoType(soType);
        printTemplate.setPageNum(new Integer(pageNum));
        printTemplate.setIndexItem(new Integer(indexItem));
        return "modules/print/printTemplateForm";
    }


    @RequestMapping(value = "init")
    public String init(PrintTemplate printTemplate, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
        return "modules/print/printTemplateInit";
    }

    @RequestMapping(value = "list")
    public String list(PrintTemplate printTemplate,HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
        Page<PrintTemplate> page = printService.find(new Page<PrintTemplate>(request, response), printTemplate);
        model.addAttribute("page", page);
        return "modules/print/printTemplateList";
    }

    @RequestMapping(value = "initSave")
    public String initSave(PrintTemplate printTemplate, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
        List<PrintTemplate> printTemplates = new ArrayList<PrintTemplate>();
        // 初始化 - PRINT_INITA
        PrintTemplate template1 = new PrintTemplate();
        template1.setCertType(printTemplate.getCertType());
        template1.setSoType(printTemplate.getSoType());
        template1.setPageNum(printTemplate.getPageNum());
        template1.setIndexItem(1);
        template1.setParaType("PRINT_INITA");
        template1.setParaNum(5);
        template1.setParaName("初始化");
        template1.setParaCode1("0");
        template1.setParaCode2("0");
        template1.setParaCode3(printTemplate.getParaCode3());
        template1.setParaCode4(printTemplate.getParaCode4());
        template1.setParaCode5(printTemplate.getParaCode5());

        // 纸张大小
        PrintTemplate template2 = new PrintTemplate();
        template2.setCertType(printTemplate.getCertType());
        template2.setSoType(printTemplate.getSoType());
        template2.setPageNum(printTemplate.getPageNum());
        template2.setIndexItem(2);
        template2.setParaType("SET_PRINT_PAGESIZE");
        template2.setParaNum(4);
        template2.setParaName("纸张设置");
        template2.setParaCode1("1"); // 打印方向 1---纵(正)向打印，固定纸张；  2---横向打印，固定纸张； 3---纵(正)向打印，宽度固定，高度按打印内容的高度自适应； 0(或其它)----打印方向由操作者自行选择或按打印机缺省设置；
        template2.setParaCode2(printTemplate.getParaCode6()); // 设定自定义纸张宽度，整数或字符型，整数时缺省长度单位为0.1mm, 譬如该参数值为45，则表示4.5毫米。字符型时可包含单位名：in(英寸)、cm(厘米) 、mm(毫米) 、pt(磅)、px(1/96英寸)，如“10mm”表示10毫米。 不是数值或数值小于等于0时本参数无效。
        template2.setParaCode3(printTemplate.getParaCode7()); // 固定纸张时设定纸张高；高度自适应时设定纸张底边的空白高。整数或字符型，整数时缺省长度单位为0.1毫米。字符型时可包含单位名：in(英寸)、cm(厘米) 、mm(毫米) 、pt(磅)、px(1/96英寸)，如“10mm”表示10毫米。不是数值或数值小于等于0时本参数无效。
        template2.setParaCode4("CreateCustomPage"); // 所选纸张类型名，字符型。不同打印机所支持的纸张可能不一样，这里的名称同操作系统内打印机属性中的纸张名称，支持操作系统内的自定义纸张。关键字“CreateCustomPage”会按以上宽度和高度自动建立一个自定义纸张，所建立的纸张名固定为“LodopCustomPage”，多次建立则刷新该纸张的大小值。


        // 打印模式 - SET_PRINT_MODE “POS_BASEON_PAPER”：设置输出位置以纸张边缘为基点。整数或字符型，1或“1”或“True”=是,否则不是。默认值是“否”，也就是默认不以纸张边缘为基点，而以可打印区域的边缘为基点。
        PrintTemplate template6 = new PrintTemplate();
        template6.setCertType(printTemplate.getCertType());
        template6.setSoType(printTemplate.getSoType());
        template6.setPageNum(printTemplate.getPageNum());
        template6.setIndexItem(3);
        template6.setParaType("SET_PRINT_MODE");
        template6.setParaNum(2);
        template6.setParaName("打印模式-以纸张边缘为基点");
        template6.setParaCode1("POS_BASEON_PAPER");
        template6.setParaCode2("true");

        // 设置模式 - SET_SHOW_MODE BKIMG_IN_PREVIEW 打印预览时是否包含背景图。
        PrintTemplate template7 = new PrintTemplate();
        template7.setCertType(printTemplate.getCertType());
        template7.setSoType(printTemplate.getSoType());
        template7.setPageNum(printTemplate.getPageNum());
        template7.setIndexItem(4);
        template7.setParaType("SET_SHOW_MODE");
        template7.setParaNum(2);
        template7.setParaName("设置模式-预览展现背景图");
        template7.setParaCode1("BKIMG_IN_PREVIEW");
        template7.setParaCode2("true");

        // 字体 - SET_PRINT_STYLE FontSize
        PrintTemplate template3 = new PrintTemplate();
        template3.setCertType(printTemplate.getCertType());
        template3.setSoType(printTemplate.getSoType());
        template3.setPageNum(printTemplate.getPageNum());
        template3.setIndexItem(5);
        template3.setParaType("SET_PRINT_STYLE");
        template3.setParaNum(2);
        template3.setParaName("字体");
        template3.setParaCode1("FontName"); // FontName的值： 字符型，与操作系统字体名一致，缺省是“宋体”。
        template3.setParaCode2(printTemplate.getParaCode1());

        // 字体大小 - SET_PRINT_STYLE FontSize
        PrintTemplate template4 = new PrintTemplate();
        template4.setCertType(printTemplate.getCertType());
        template4.setSoType(printTemplate.getSoType());
        template4.setPageNum(printTemplate.getPageNum());
        template4.setIndexItem(6);
        template4.setParaType("SET_PRINT_STYLE");
        template4.setParaNum(2);
        template4.setParaName("字体大小");
        template4.setParaCode1("FontSize"); // FontSize的值：数值型，单位是pt，缺省值是9，可以含小数，如13.5。
        template4.setParaCode2(printTemplate.getParaCode2());

        // 背景图片 - SET_SHOW_MODE BKIMG_IN_PREVIEW
        PrintTemplate template5 = new PrintTemplate();
        template5.setCertType(printTemplate.getCertType());
        template5.setSoType(printTemplate.getSoType());
        template5.setPageNum(printTemplate.getPageNum());
        template5.setIndexItem(7);
        template5.setParaType("ADD_PRINT_SETUP_BKIMG");
        template5.setParaNum(1);
        template5.setParaName("背景图片");
        template5.setParaCode1(printTemplate.getParaName());

        printTemplates.add(template1);
        printTemplates.add(template2);
        printTemplates.add(template3);
        printTemplates.add(template4);
        printTemplates.add(template5);
        printTemplates.add(template6);
        printTemplates.add(template7);

        printService.init(printTemplates);
        addMessage(redirectAttributes,"打印模板初始化成功！");
        return "redirect:"+ Global.getAdminPath()+"/print/list";
    }

    @RequestMapping(value = "printHtml")
    public String printHtml(String soid,String pageNum,HttpServletRequest request, HttpServletResponse response, Model model) {

        String printData = "";
        String printMultiPageTag = TagUtils.getTagChar("PRINT_MULTI_PAGE", "ZZ", -1, -1, "0"); // 0-单页打印   1-多页打印 默认单页
        Map<String,Object> dataMap = new HashMap<String, Object>();
        SoPlan soPlan = planService.findBySoid(soid);
        ServAssociateConstructor servAcInfo = servAssociateConstructorMapper.findByUserId(soPlan.getUserId());
        dataMap.put("serv",servAcInfo);
        dataMap.put("soPlan",soPlan);
        BeanMapper.toMap(dataMap);
        List<PrintTemplate> tpls = new ArrayList<PrintTemplate>();
        if ("0".equals(printMultiPageTag)) {
            tpls = printTemplateMapper.findByCertTypeAndSoTypeAndPageNum("AC","01",Integer.parseInt(pageNum));// 单页
        } else {
            tpls = printTemplateMapper.findByCertTypeAndSoType("AC", "01"); // 多页
        }
        printData = geneJson(dataMap,tpls);
        logger.debug(printData);
        for (PrintTemplate template:tpls) {
            if ("PRINT_INITA".equals(template.getParaType())){
                String heightNum = template.getParaCode4();
                if (!"".equals(heightNum)) {
                    model.addAttribute("heightNum",heightNum);
                }
                break;
            }
        }
        model.addAttribute("printData", printData);
        model.addAttribute("print_multi_page",printMultiPageTag);
        model.addAttribute("soid",soid);
        return "modules/print/PrintHtml";
    }

    /**
     * 拼装打印模板数据
     * @param dataMap
     * @param tpls
     * @return
     */
    private String geneJson(Map<String,Object> dataMap,List<PrintTemplate> tpls) {

        String result = "";
        for (PrintTemplate tpl : tpls) {
            if (tpl.getParaCode5() != null && tpl.getParaCode5().startsWith("$")) {
                String paraStr = tpl.getParaCode5().substring(1);
                String[] str = paraStr.split("\\|");
                String dictType = "";
                String eleValue = "";
                if (str.length > 1) {
                    dictType = str[1];
                }
                String[] str1 = str[0].split("\\.");
                if (str1.length > 1) {
                    String eleStr = str1[1];
                    Map<String, Object> baseMap = new HashMap<String, Object>();
                    if ("serv".equals(str1[0])) {
                        ServAssociateConstructor serv = (ServAssociateConstructor) dataMap.get("serv");
                        baseMap = BeanMapper.toMap(serv);
                    } else if ("soPlan".equals(str1[0])) {
                        SoPlan soPlan = (SoPlan) dataMap.get("soPlan");
                        baseMap = BeanMapper.toMap(soPlan);
                    }
                    if (baseMap.containsKey(eleStr)) {
                        if (!"".equals(dictType)) {
                            if ("YEAR".equals(dictType)) {
                                Date tmpDate = getDate(baseMap,eleStr);
                                eleValue = DateUtils.getYear(tmpDate);
                            } else if ("MONTH".equals(dictType)) {
                                Date tmpDate = getDate(baseMap,eleStr);
                                eleValue = DateUtils.getMonth(tmpDate);
                            } else if ("DAY".equals(dictType)) {
                                Date tmpDate = getDate(baseMap,eleStr);
                                eleValue = DateUtils.getDay(tmpDate);
                            } else if (dictType.startsWith("substring")) {
                                String[] s = dictType.substring(10,dictType.length() - 1).split(",");
                                eleValue = getString(baseMap,eleStr,"");
                                if (s.length > 1) {
                                    eleValue = eleValue.substring(Integer.parseInt(s[0]),Integer.parseInt(s[1]));
                                } else if (s.length > 0){
                                    eleValue = eleValue.substring(Integer.parseInt(s[0]));
                                }
                            } else if ("COMPANY".equals(dictType)) {
                                Integer companyId = getInt(baseMap, eleStr,0);
                                eleValue = UserUtils.getCompanyById(companyId)!=null ? UserUtils.getCompanyById(companyId).getCompanyName():"";
                            }else {
                                String dictLabel = DictUtils.getDictLabel((String) baseMap.get(eleStr), dictType, "");
                                eleValue = dictLabel;
                            }
                        } else {
                            eleValue = getString(baseMap,eleStr,"");
                        }
                    }
                } else {
                    if ("SYSDATE".equals(str1[0])) {
                        if (!"".equals(dictType)) {
                            if ("YEAR".equals(dictType)) {
                                eleValue = DateUtils.getYear();
                            } else if ("MONTH".equals(dictType)) {
                                eleValue = DateUtils.getMonth();
                            } else if ("DAY".equals(dictType)) {
                                eleValue = DateUtils.getDay();
                            }
                        } else {
                            eleValue = DateUtils.formatDate(new Date());
                        }
                    } else {
                        eleValue = getString(dataMap,str1[0],"");
                    }
                }
                tpl.setParaCode5(eleValue);
            } else {
                tpl.setParaCode5(tpl.getParaCode5());
            }
        }

        result = JsonMapper.toJsonString(tpls);
        logger.debug(result);
        return result;
    }

    public Object get(Map<String,Object> baseMap,String key, Object def) {
        Object value = baseMap.get(key);
        return value == null ? def : value;
    }
    private String getString(Map<String,Object> baseMap,String key,String defaultValue) {
        String dataStr = "";
        if (baseMap.get(key) instanceof Date) {
            dataStr = DateUtils.formatDate((Date) baseMap.get(key), "yyyy-MM-dd");
            logger.debug("i'm date" + dataStr);
        } else {
            dataStr = get(baseMap,key,defaultValue).toString();
        }
        return dataStr;
    }

    private Integer getInt(Map<String,Object> baseMap,String key,int defaultValue) {
        String value = getString(baseMap,key, "");
        return "".equals(value) ? defaultValue : Integer.parseInt(value);
    }

    public boolean getBoolean(Map<String,Object> baseMap,String key, boolean defaultValue) {
        String value = getString(baseMap,key, "");
        return "".equals(value) ? defaultValue : Boolean.valueOf(value).booleanValue();
    }

    public double getDouble(Map<String,Object> baseMap,String key, double defaultValue) {
        String value = getString(baseMap,key, "");
        return "".equals(value) ? defaultValue : Double.parseDouble(value);
    }

    public Date getDate(Map<String,Object> baseMap,String key,Date ... defaultValue) {
        if (baseMap.get(key) instanceof Date) {
            return (Date)baseMap.get(key);
        } else {
            if (defaultValue != null) {
                return defaultValue[0];
            }
            return null;
        }
    }

    @RequestMapping(value = "testTable")
    public String test() {
        return "modules/print/testTable";
    }
}
