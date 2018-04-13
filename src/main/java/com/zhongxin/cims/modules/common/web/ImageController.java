/*
 * The MIT License
 *
 * Copyright 2013 jdmr.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package com.zhongxin.cims.modules.common.web;

import com.zhongxin.cims.common.config.Constants;
import com.zhongxin.cims.common.config.Global;
import com.zhongxin.cims.common.mapper.JsonMapper;
import com.zhongxin.cims.common.utils.FileUtils;
import com.zhongxin.cims.common.utils.ImageCut;
import com.zhongxin.cims.common.web.BaseController;
import com.zhongxin.cims.modules.ac.dao.CourseMapper;
import com.zhongxin.cims.modules.ac.dao.LessonMapper;
import com.zhongxin.cims.modules.ac.entity.Course;
import com.zhongxin.cims.modules.ac.entity.Lesson;
import com.zhongxin.cims.modules.common.dao.SealMapper;
import com.zhongxin.cims.modules.common.entity.Seal;
import com.zhongxin.cims.modules.common.entity.So;
import com.zhongxin.cims.modules.cp.entity.SoAssess;
import com.zhongxin.cims.modules.cp.service.SoAssessService;
import com.zhongxin.cims.modules.sys.utils.SeqUtils;
import com.zhongxin.cims.modules.sys.utils.UserUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import com.zhongxin.cims.modules.common.dao.SoAttachmentMapper;
import com.zhongxin.cims.modules.common.entity.SoAttachment;
import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Import;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.io.*;
import java.util.*;
import java.util.List;

/**
 *
 * @author jdmr
 */
@Controller
@RequestMapping(value = "${adminPath}/file")
public class ImageController extends BaseController{

    @Autowired
    private SoAttachmentMapper soAttachmentMapper;

    @Autowired
    private SoAssessService soAssessService;

    @Autowired
    private SealMapper sealMapper;

    @Autowired
    private CourseMapper courseMapper;

    @Autowired
    private LessonMapper lessonMapper;

    private String fileUploadDirectory = Global.getTmpDir();

    private static final String headPhotoBaseDir = Global.getHeadPhotoBaseDir();

    private static final String headPhotoTmpDir = Global.getHeadPhotoTmpDir();

    private String fileSoImageDirectory = Global.getSoImageDir();

    @ModelAttribute(value = "soAttachment")
    public SoAttachment get(@RequestParam(required=false) Long id) {
        if (id != null){
            return soAttachmentMapper.selectByPrimaryKey(id);
        }else{
            return new SoAttachment();
        }
    }

/*    @ModelAttribute
    public SoAssess get(@RequestParam(required=false) String soid) {
        if (soid != null && !"".equals(soid)){
            SoAssess soAssess = soAssessService.findBySoid(soid);
            List<SoAttachment> attachments = soAttachmentMapper.selectBySoid(soid);
            soAssess.setSoAttachments(attachments);
            return soAssess;
        }else{
            return new SoAssess();
        }
    }*/

    @RequestMapping(value = "")
    public String index( HttpServletRequest request, HttpServletResponse response) {
        return "modules/file/upload";
    }

    @RequestMapping(value = "upload", method = RequestMethod.GET)
    public @ResponseBody
    Map list(HttpServletRequest request) {
        logger.debug("uploadGet called");
        List<SoAttachment> list = soAttachmentMapper.selectBySoid(request.getSession().getId());
        for(SoAttachment image : list) {
            image.setUrl(request.getContextPath()+Global.getAdminPath() + "/file/picture/"+image.getId());
            image.setThumbnailUrl(request.getContextPath()+Global.getAdminPath() + "/file/thumbnail/"+image.getId());
            image.setDeleteUrl(request.getContextPath()+Global.getAdminPath() + "/file/delete/"+image.getId());
            image.setDeleteType("DELETE");
        }
        Map<String, Object> files = new HashMap();
        files.put("files", list);
        logger.debug("Returning: {}", files);
        return files;
    }

    @RequestMapping(value = "upload", method = RequestMethod.POST)
    public @ResponseBody
    Map upload(MultipartHttpServletRequest request, HttpServletResponse response) {
        logger.debug("uploadPost called");

        Iterator<String> itr = request.getFileNames();
        String soType = request.getParameter("soType") ;
        String appId = request.getParameter("appId");
        String soid = request.getParameter("soid");
        MultipartFile mpf;
        List<SoAttachment> list = new LinkedList();

        while (itr.hasNext()) {
            mpf = request.getFile(itr.next());
            logger.debug("Uploading {}", mpf.getOriginalFilename());

            String newFilenameBase = UUID.randomUUID().toString();
            String originalFileExtension = mpf.getOriginalFilename().substring(mpf.getOriginalFilename().lastIndexOf("."));
            String newFilename = newFilenameBase + originalFileExtension;
            String storageDirectory = fileUploadDirectory;
            String contentType = mpf.getContentType();

            File newFile = new File(storageDirectory + "/" + newFilename);
            try {
                mpf.transferTo(newFile);

                SoAttachment image = new SoAttachment();
                Image img=ImageIO.read(newFile);
                if(img != null) {
                    BufferedImage thumbnail = Scalr.resize(ImageIO.read(newFile), 290);
                    String thumbnailFilename = newFilenameBase + "-thumbnail.png";
                    File thumbnailFile = new File(storageDirectory + "/" + thumbnailFilename);
                    ImageIO.write(thumbnail, "png", thumbnailFile);
                    image.setThumbnailFilename(thumbnailFilename);
                    image.setThumbnailSize(thumbnailFile.length());
                }


                image.setName(mpf.getOriginalFilename());
                image.setNewFilename(newFilename);
                image.setContentType(contentType);
                image.setSize(mpf.getSize());
                image.setSoid((soid != null && !"".equals(soid))? soid:request.getSession().getId());
                image.setPass("0");
                image.setCreateDate(new Date());
                image.setUpdateDate(new Date());
                //入参获取方式?
                image.setAppId(appId);
                image.setSoType(soType);
                image.setSts(Constants.GLOBAL_SO_CP_UPLOAD_STS_COMMIT);
                soAttachmentMapper.insert(image);

                image.setUrl(request.getContextPath()+Global.getAdminPath() + "/file/picture/"+image.getId());
                image.setThumbnailUrl(request.getContextPath()+Global.getAdminPath() + "/file/thumbnail/"+image.getId());
                image.setDeleteUrl(request.getContextPath()+Global.getAdminPath() + "/file/delete/"+image.getId());
                image.setDeleteType("DELETE");

                list.add(image);

            } catch(IOException e) {
                logger.error("Could not upload file "+mpf.getOriginalFilename(), e);
            }

        }
        Map<String, Object> files = new HashMap();
        files.put("files", list);
        return files;
    }



    @RequestMapping(value = "operUpload", method = RequestMethod.POST)
    public @ResponseBody
    Map operUpload(MultipartHttpServletRequest request, HttpServletResponse response) {
        logger.debug("uploadPost called");

        Iterator<String> itr = request.getFileNames();
        String lessonId = request.getParameter("soType") ;
        String courseId = request.getParameter("appId");
        String soid = request.getParameter("soid");
        MultipartFile mpf;
        List<SoAttachment> list = new LinkedList();
        while (itr.hasNext()) {
           mpf = request.getFile(itr.next());
            logger.debug("Uploading {}", mpf.getOriginalFilename());
            int fileId = SeqUtils.getNextValue("FILE_SEQ");
            Long thumbnailSize = null;
            String fileName = mpf.getOriginalFilename();
            String times = mpf.getOriginalFilename().substring(0,mpf.getOriginalFilename().indexOf("."));
            String newFilename = fileId +"-"+times;
            String storageDirectory = fileSoImageDirectory+soid+"/"+courseId+"/"+lessonId+"/";
            FileUtils.createDirectory(storageDirectory);
            String contentType = mpf.getContentType();
          /*  if(!times.matches("^[0-9]*$")){
                Map<String, Object> files = new HashMap();
                files.put("files", "上传图片名须为数字类型");
                Map msg = new HashMap();
                msg.put("msg","上传图片名须为数字类型！");
                return msg;
            }
*/
            File newFile = new File(storageDirectory + "/" + fileName);
            try {
               mpf.transferTo(newFile);

                SoAttachment image = new SoAttachment();
                Image img=ImageIO.read(newFile);
                if(img != null) {
                    BufferedImage thumbnail = Scalr.resize(ImageIO.read(newFile), 190);
                    String thumbnailFilename = newFilename + ".png";
                    File thumbnailFile = new File(storageDirectory + "/" + thumbnailFilename);
                    ImageIO.write(thumbnail, "png", thumbnailFile);
                    image.setThumbnailFilename(thumbnailFilename);
                    image.setThumbnailSize(new Long(times));
                    image.setNewFilename(thumbnailFilename);
                }


                image.setName(fileName);
                image.setContentType(contentType);
                image.setSize(mpf.getSize());
                image.setSoid((soid != null && !"".equals(soid))? soid:request.getSession().getId());
                image.setPass("0");
                image.setCreateDate(new Date());
                image.setUpdateDate(new Date());
                image.setAppId(courseId);
                image.setSoType(lessonId);
                image.setPath(storageDirectory);
                image.setSts(Constants.GLOBAL_SO_CP_UPLOAD_STS_COMMIT);
                soAttachmentMapper.insert(image);

                image.setUrl(request.getContextPath()+Global.getAdminPath() + "/file/picture/"+image.getId());
                image.setThumbnailUrl(request.getContextPath()+Global.getAdminPath() + "/file/thumbnail/"+image.getId());
                image.setDeleteUrl(request.getContextPath()+Global.getAdminPath() + "/file/delete/"+image.getId());
                image.setDeleteType("DELETE");

                list.add(image);

        } catch(IOException e) {
                logger.error("Could not upload file "+mpf.getOriginalFilename(), e);
            }

        }
        Map<String, Object> files = new HashMap();
        files.put("files", list);
        return files;
    }

    @RequestMapping(value = "picture/{id}", method = RequestMethod.GET)
    public void picture(HttpServletResponse response, @PathVariable Long id) {
        SoAttachment image = soAttachmentMapper.selectByPrimaryKey(id);
        File imageFile = new File(fileUploadDirectory+"/"+image.getNewFilename());
        if(image != null && image.getPath() != null && !image.getPath().isEmpty()){
            imageFile = new File(image.getPath()+image.getNewFilename());
        }

        response.setContentType(image.getContentType());
        //response.setContentLength(image.getSize().intValue());
        try {
            InputStream is = new FileInputStream(imageFile);
            IOUtils.copy(is, response.getOutputStream());
        } catch(IOException e) {
            logger.error("Could not show picture "+id, e);
        }
    }

    @RequestMapping(value = "thumbnail/{id}", method = RequestMethod.GET)
    public void thumbnail(HttpServletResponse response, @PathVariable Long id) {
        SoAttachment image = soAttachmentMapper.selectByPrimaryKey(id);
        File imageFile = new File(fileUploadDirectory+"/"+image.getThumbnailFilename());
        if(image != null && image.getPath() != null && !image.getPath().isEmpty()){
            imageFile = new File(image.getPath()+image.getThumbnailFilename());
        }
        response.setContentType(image.getContentType());
        //response.setContentLength(image.getThumbnailSize().intValue());
        try {
            InputStream is = new FileInputStream(imageFile);
            IOUtils.copy(is, response.getOutputStream());
        } catch(IOException e) {
            logger.error("Could not show thumbnail "+id, e);
        }
    }

    @RequestMapping(value = "comThumbnail/{id}", method = RequestMethod.GET)
    public void comThumbnail(HttpServletResponse response, @PathVariable Long id) {
        SoAttachment image = soAttachmentMapper.selectComByPrimaryKey(id);
        File imageFile = new File(fileUploadDirectory+"/"+image.getThumbnailFilename());
        if(image != null && image.getPath() != null && !image.getPath().isEmpty()){
            imageFile = new File(image.getPath()+image.getThumbnailFilename());
        }
        response.setContentType(image.getContentType());
        //response.setContentLength(image.getThumbnailSize().intValue());
        try {
            InputStream is = new FileInputStream(imageFile);
            IOUtils.copy(is, response.getOutputStream());
        } catch(IOException e) {
            logger.error("Could not show thumbnail "+id, e);
        }
    }

    @RequestMapping(value = "delete/{id}", method = RequestMethod.DELETE)
    public @ResponseBody
    List delete(@PathVariable Long id) {
        SoAttachment image = soAttachmentMapper.selectByPrimaryKey(id);
        File imageFile = new File(image.getPath()+"/"+image.getNewFilename());
        imageFile.delete();
        File thumbnailFile = new File(image.getPath()+"/"+image.getThumbnailFilename());
        thumbnailFile.delete();
        soAttachmentMapper.deleteByPrimaryKey(id);
        List<Map<String, Object>> results = new ArrayList();
        Map<String, Object> success = new HashMap();
        success.put("success", true);
        results.add(success);
        return results;
    }
    @ResponseBody
    @RequestMapping(value = "deleteByPk")
    public String deleteByPk(Long id) {

        Map map = new HashMap();
        int flag =   soAttachmentMapper.deleteByPrimaryKey(id);
        map.put("flag", flag);
        return JsonMapper.nonDefaultMapper().toJson(map);
    }


    @RequestMapping(value = "auditImg")
    public @ResponseBody String auditImg(Long id,String imgpass,HttpServletRequest request){
        SoAttachment attachment = soAttachmentMapper.selectByPrimaryKey(id);
        attachment.setSts("1");
        attachment.setUpdateDate(new Date());
        attachment.setPass(imgpass);
        attachment.setPassUserId(UserUtils.getUser().getId());
        attachment.setPassDate(new Date());
        soAttachmentMapper.updateByPrimaryKeySelective(attachment);
        return imgpass;
    }

    @RequestMapping(value = "seal/{localId}/{sealId}", method = RequestMethod.GET)
    public void seal(HttpServletResponse response, @PathVariable String localId, @PathVariable String sealId) {
        Seal image = sealMapper.selectBySealId(sealId, localId);
        File imageFile = new File(image.getPath()+image.getName());

        response.setContentType(image.getContentType());
        try {
            InputStream is = new FileInputStream(imageFile);
            IOUtils.copy(is, response.getOutputStream());
        } catch(IOException e) {
            logger.error("Could not show picture "+"1", e);
        }
    }

    /**
     * 二级建造师图片获取
     * @param response
     * @param id
     */
    @RequestMapping(value = "pic/{id}", method = RequestMethod.GET)
    public void pic(HttpServletResponse response, @PathVariable Long id) {
        Course image = courseMapper.selectByPrimaryKey(id);
        File imageFile = new File(fileUploadDirectory+"/"+image.getPath());// 默认路径

        // 如果数据库中有哭经，取数据库配置路径
        if(image != null && image.getImagePath() != null && !image.getImagePath().isEmpty()){
            imageFile = new File(image.getImagePath() + "/" + image.getPath());
        }

        response.setContentType(image.getType());
        try {
            InputStream is = new FileInputStream(imageFile);
            IOUtils.copy(is, response.getOutputStream());
        } catch(IOException e) {
            logger.error("Could not show picture "+id, e);
        }
    }
    @RequestMapping(value = "uploadPhoto")
    public String uploadPhoto(String width,String height,Model model) {
        model.addAttribute("resizeWidth", width);
        model.addAttribute("width", width);
        model.addAttribute("height", height);
        return "modules/ac/course/headPhoto";
    }

    @RequestMapping(value = "headPhotoUpload", method = RequestMethod.POST)
    @ResponseBody
    public Map headPhotoUpload(String soid,String uploadPath,MultipartHttpServletRequest request, HttpServletResponse response) {
        return new HashMap();
    }

    @RequestMapping(value = "uploadHeadImage")
    @ResponseBody
    public String uploadHeadImage(
            HttpServletRequest request,
            @RequestParam(value = "x") String x,
            @RequestParam(value = "y") String y,
            @RequestParam(value = "h") String h,
            @RequestParam(value = "w") String w,
            @RequestParam(value = "imgFile") MultipartFile imageFile
    ) throws Exception {
        System.out.println("==========Start=============");
        String realPath = request.getSession().getServletContext().getRealPath("/");
        String resourcePath = "resources/uploadImages/";
        Map<String,String> map = new HashMap<String, String>();
        if (imageFile != null) {
            String newFilenameBase = UUID.randomUUID().toString();
            String originalFileExtension = imageFile.getOriginalFilename().substring(imageFile.getOriginalFilename().lastIndexOf("."));
            String fileName = newFilenameBase + originalFileExtension;
            int end = fileName.lastIndexOf(".");
            String saveName = fileName.substring(0, end);
            File dir = new File(realPath + resourcePath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            File file = new File(dir, saveName + "_src.jpg");
            imageFile.transferTo(file);
            String srcImagePath = realPath + resourcePath + saveName;
            int imageX = Integer.parseInt(x);
            int imageY = Integer.parseInt(y);
            int imageH = Integer.parseInt(h);
            int imageW = Integer.parseInt(w);
            //这里开始截取操作
            System.out.println("==========imageCutStart=============");
            logger.debug("x=" + imageX);
            logger.debug("y=" + imageY);
            logger.debug("w=" + imageW);
            logger.debug("h=" + imageH);
            ImageCut.imgCut(srcImagePath, imageX, imageY, imageW, imageH);
            System.out.println("==========imageCutEnd=============");
            map.put("code","sucess");
            map.put("message","上传成功！");
        }
        //JsonMapper.toJsonString(map);
        return JsonMapper.toJsonString(map);
    }

    /**
     *
     */
    @RequestMapping("uploadHeaderPicTmp")
    @ResponseBody
    public String uploadHeaderPic(String inputId,double width,MultipartHttpServletRequest request, HttpServletResponse response) {
        try {
            double resizeWidth = width;
            MultipartFile realPicFile = request.getFile(inputId);
            Map map = new HashMap();
            logger.debug("file size = 【" + realPicFile.getSize() + "】");
            if (realPicFile.getSize() > 1024*1024) {
                map.put("error","上传的文件不能超过1M!");
                return JsonMapper.toJsonString(map);
            }
            InputStream in = realPicFile.getInputStream();
            //String path = request.getSession().getServletContext().getRealPath("/");
            String path = headPhotoTmpDir;
            //path += fileUploadDirectory;
            String newFilenameBase = UUID.randomUUID().toString();
            String originalFileExtension = realPicFile.getOriginalFilename().substring(realPicFile.getOriginalFilename().lastIndexOf("."));
            String fileName = newFilenameBase + originalFileExtension;
            File f = new File(path + "/" + fileName);
            FileUtils.copyInputStreamToFile(in, f);

            // 读取源图像
            BufferedImage bi = ImageIO.read(f);
            //前端页面显示的并非原图大小，而是经过了一定的压缩，所以不能使用原图的宽高来进行裁剪，需要使用前端显示的图片宽高
            double srcWidth = bi.getWidth(); // 源图宽度
            double srcHeight = bi.getHeight();// 源图高度
            double destHeight = 0;
            width = width < 400 ? 400 : width;
            if (srcWidth > width) {
                destHeight = width * ( srcHeight / srcWidth);
            } else {
                destHeight = srcHeight;
                width = srcWidth;
            }

            //return "{\"path\" : \"" + "/cims/a/file/headPhoto/" + newFilenameBase + "\"}";
            map.put("path", "/nmjzs/a/file/headPhoto/" + fileName + "/show");
            map.put("width", width);
            map.put("height", destHeight + 8);
            map.put("resizeWidth", resizeWidth);
//            response.setHeader("Content-type", "text/html;charset=UTF-8");
//            response.setContentType("text/html");
            return JsonMapper.toJsonString(map);
        } catch (Exception e) {
            logger.error("upload header picture error : ", e);
        }
        return null;
    }

    @RequestMapping("uploadHeaderPic")
    @ResponseBody
    public Map cutImage(String srcImageFile, int x, int y, int destWidth, int destHeight, int srcShowWidth, int srcShowHeight, int resizeWidth,
                        HttpServletRequest request) {
        try {
            srcImageFile = srcImageFile.replace("/show","");
            String path = headPhotoTmpDir;
            Image img;
            ImageFilter cropFilter;
            String srcFileName = FilenameUtils.getName(srcImageFile);

            // 读取源图像
            File srcFile = new File(path + "/" + srcFileName);

            BufferedImage bi = ImageIO.read(srcFile);
            //前端页面显示的并非原图大小，而是经过了一定的压缩，所以不能使用原图的宽高来进行裁剪，需要使用前端显示的图片宽高
            int srcWidth = bi.getWidth(); // 源图宽度
            int srcHeight = bi.getHeight(); // 源图高度
            if (srcShowWidth == 0)
                srcShowWidth = srcWidth;
            if (srcShowHeight == 0)
                srcShowHeight = srcHeight;

            if (srcShowWidth >= destWidth && srcShowHeight >= destHeight) {
                Image image = bi.getScaledInstance(srcShowWidth, srcShowHeight, Image.SCALE_DEFAULT);//获取缩放后的图片大小
                cropFilter = new CropImageFilter(x, y, destWidth, destHeight);
                img = Toolkit.getDefaultToolkit().createImage(new FilteredImageSource(image.getSource(), cropFilter));
                BufferedImage tag = new BufferedImage(destWidth, destHeight, BufferedImage.TYPE_INT_RGB);
                Graphics g = tag.getGraphics();
                g.drawImage(img, 0, 0, null); // 绘制截取后的图
                g.dispose();

                String ext = FilenameUtils.getExtension(srcImageFile);

                String destPath = headPhotoBaseDir;
                //String fileName = srcFileName + "_last" + "." + ext;
                File destImageFile = new File(destPath + "/" + srcFileName);
                // 输出为文件
                ImageIO.write(tag, ext, destImageFile);

                BufferedImage thumbnail = Scalr.resize(ImageIO.read(destImageFile), resizeWidth);
                ImageIO.write(thumbnail, ext, destImageFile);

/*                loginUser.setPicPath(SystemConst.SYSTEM_CONTEXT_PATH_VALUE + HEADER_PIC + "/" + fileName);
                userService.update(loginUser);*/
                // 删除原临时文件
                //srcFile.delete();

                Map msg = new HashMap();
                msg.put("code","success");
                msg.put("msg","上传成功！");
                msg.put("filename",srcFileName);
                return msg;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    @RequestMapping(value = "headPhoto/{name}/show", method = RequestMethod.GET)
    public void headPic(HttpServletResponse response, @PathVariable("name") String name) {
        File imageFile = new File(headPhotoTmpDir+"/"+name);
        try {
            InputStream is = new FileInputStream(imageFile);
            IOUtils.copy(is, response.getOutputStream());
        } catch(IOException e) {
            logger.error("不能展示图片 "+name, e);
        }
    }

    @RequestMapping(value = "headPhoto/{name}/final", method = RequestMethod.GET)
    public void headPicFinal(HttpServletResponse response, @PathVariable("name") String name) {
        File imageFile = new File(headPhotoBaseDir+"/"+name);
        try {
            InputStream is = new FileInputStream(imageFile);
            //response.setContentType("image/jpg");
            IOUtils.copy(is, response.getOutputStream());
        } catch(IOException e) {
            logger.error("不能展示图片 "+name, e);
        }
    }
}
