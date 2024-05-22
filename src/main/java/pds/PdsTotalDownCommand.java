package pds;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PdsTotalDownCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null? 0 : Integer.parseInt(request.getParameter("idx"));
		
		// DB에 저장된 파일의 정보(원본파일/서버에 저장된 파일)를 가져온다.
		PdsDAO dao = new PdsDAO();
		PdsVO vo = dao.getPdsIdxSearch(idx);
		
		// 원본파일명과 서버저장파일명을 각각 분린시킨다.
		String[] fNames = vo.getfName().split("/");
		String[] fSNames = vo.getfSName().split("/");
		
		// 파일을 압축하기 위해 필요한 객체들을 선언한다.
		FileInputStream fis = null;
		FileOutputStream fos = null;
		ZipOutputStream zos = null;
		ServletOutputStream sos = null;
		
		String realPath = request.getServletContext().getRealPath("/images/pds/");
		String zipPath = request.getServletContext().getRealPath("/images/pds/temp/");
		String zipName = vo.getTitle() + ".zip";
		
		fos = new FileOutputStream(zipPath + zipName);
		zos = new ZipOutputStream(fos);
		
		byte[] buffer = new byte[2048];
		int size = 0;
		
		//각각의 파일을 압축처리하기위한 fis를 생성후 zos에 처리한다.
		for(int i=0; i<fSNames.length; i++) {
			File file = new File(realPath + fSNames[i]);
			fis = new FileInputStream(file);
			zos.putNextEntry(new ZipEntry(fSNames[i]));
			
			while((size = fis.read(buffer)) != -1) {
				zos.write(buffer, 0, size);
			}
			zos.flush();
			zos.closeEntry();
			fis.close();
		}
		zos.close();
		
		
		// 서버에서 압축작업이 완료되면, 압축파일을 클라이언트로 전송하고, 서버에 존재하는 압축파일은 삭제시킨다.
		// 클라이언트로 파일은 전송할시는 HTTP 프로토콜 형식에 맞도록 헤더에 정보를 제공해줘야한다.
		String downloadName = "";
		// 익스프롤러가 아니면
		if(request.getHeader("user-agent").indexOf("MSIE") == -1) {
			downloadName = new String(zipName.getBytes("UTF-8"), "8859_1");
		}
		else
			downloadName = new String(zipName.getBytes("EUC-KR"), "8859_1");
		
		// 헤더에 정보를 첨부..
		response.setHeader("Content-Disposition", "attachment;filename=" + downloadName);
		
		fis = new FileInputStream(zipPath + zipName);
		sos = response.getOutputStream();
		
		while((size = fis.read(buffer)) != -1) {
			sos.write(buffer, 0, size);
		}
		sos.flush();
		sos.close();
		fis.close();
		
		// 클라이언트에 파일전송을 마치면, 서버에 존재하는 zip파일을 삭제처리한다.
		new File(zipPath + zipName).delete();
		
		// 다운로드수를 증가한다.
		dao.setPdsDownNumCheck(idx);
	}

}
