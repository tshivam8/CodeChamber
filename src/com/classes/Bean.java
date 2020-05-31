package com.classes;

public class Bean {
	private String error,myOut,expOut;
	private int tstpsd,mark;
	private boolean q[]=new boolean[3];
	public Bean()
	{
		error="";
		myOut="";
		expOut="";
		tstpsd=0;
		mark=0;
		q[0]=q[1]=q[2]=false;
	}
	public Bean(String e,String m,String ex,int a)
	{
		this.error=e;
		this.myOut=m;
		this.expOut=ex;
		this.tstpsd=a;
	}
	public int getMark()
	{
		return mark;
	}
	public void setMark(int t)
	{
		mark=t;
	}
	public void setQ(int t,boolean b)
	{
		q[t-1]=b;
	}
	public boolean getQ(int t)
	{
		return q[t-1];
	}
	public String getError() {
		return error;
	}
	public void setError(String error) {
		this.error = error;
	}
	public void setTstpsd(int a)
	{
		this.tstpsd=a;
	}
	public int getTstpsd()
	{
		return tstpsd;
	}
	public String getMyOut() {
		return myOut;
	}
	public void setMyOut(String myOut) {
		this.myOut = myOut;
	}
	public String getExpOut() {
		return expOut;
	}
	public void setExpOut(String expOut) {
		this.expOut = expOut;
	}
	

}
