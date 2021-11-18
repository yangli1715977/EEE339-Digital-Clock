/*
		Student Name: Yang Li
		Studen Number: 1715977	
*/
module Div_Freq (clk, 
												clk_1HZ,
												clk_50HZ,
												clk_100HZ,
												clk_1KHZ);
input 									clk;
output							 	clk_1HZ,	
												clk_50HZ,	
												clk_100HZ,	
												clk_1KHZ;
reg 										clk_1HZ,	
												clk_50HZ,
												clk_100HZ,
												clk_1KHZ;
integer 							count1 = 0, 
												count2 = 0,
												count100 = 0, 
												count1k = 0;


always@(posedge clk)
begin 
			
        count1<=count1+1;
        if(count1<25_000_000)					//25_000_000
                clk_1HZ<=1;
        else if(count1<49_999_999)		//49999999
                clk_1HZ<=0;
        if(count1==49_999_999)				//49999999
                count1<=0;
 end
always@(posedge clk)
begin//0.4s
			count2<=count2+1;
        if(count2<625)					//1250000		10_000_000(0.4s)
                clk_50HZ<=1;	
        else if(count2<12_49)		//2499999 		19_999_999
                clk_50HZ<=0;	
        if(count2==12_49)				//2499999 		19_999_999
                count2<=0;
end
always@(posedge clk)
begin 
       count100<=count100+1;

        if(count100<25)//250000
                clk_100HZ<=1;
        else if(count100<49)//499999
                clk_100HZ<=0;  
        if(count100==49)//499999
                count100<=0;
end            
 

 always@(posedge clk) 
begin
        count1k<=count1k+1;
		  
        if(count1k<25)
                clk_1KHZ<=1;
        else if(count1k<49)
                clk_1KHZ<=0;  
        if(count1k==49)
                count1k<=0;
end
endmodule