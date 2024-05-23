package admin.review;

public class ReviewVO {
	// review 테이블의 필드정의
	private int idx;
	private String part;
	private int partIdx;
	private String mid;
	private String nickName;
	private int star;
	private String content;
	private String rDate;
	
	// reviewReply 테이블의 필드정의
	private int replyIdx;
	// private int reviewIdx; 위에 review테이블의 idx랑 같음, 중복
	private String replyMid;
	private String replyNickName;
	private String replyDate;
	private String replyContent;
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getPart() {
		return part;
	}
	public void setPart(String part) {
		this.part = part;
	}
	public int getPartIdx() {
		return partIdx;
	}
	public void setPartIdx(int partIdx) {
		this.partIdx = partIdx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getrDate() {
		return rDate;
	}
	public void setrDate(String rDate) {
		this.rDate = rDate;
	}
	public int getReplyIdx() {
		return replyIdx;
	}
	public void setReplyIdx(int replyIdx) {
		this.replyIdx = replyIdx;
	}
	public String getReplyMid() {
		return replyMid;
	}
	public void setReplyMid(String replyMid) {
		this.replyMid = replyMid;
	}
	public String getReplyNickName() {
		return replyNickName;
	}
	public void setReplyNickName(String replyNickName) {
		this.replyNickName = replyNickName;
	}
	public String getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(String replyDate) {
		this.replyDate = replyDate;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	
	
	@Override
	public String toString() {
		return "ReviewVO [idx=" + idx + ", part=" + part + ", partIdx=" + partIdx + ", mid=" + mid + ", nickName="
				+ nickName + ", star=" + star + ", content=" + content + ", rDate=" + rDate + ", replyIdx=" + replyIdx
				+ ", replyMid=" + replyMid + ", replyNickName=" + replyNickName + ", replyDate=" + replyDate
				+ ", replyContent=" + replyContent + "]";
	}
	
}
