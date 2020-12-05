package MafiaInterface_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class DynamiteAmountInfo_64 extends MovieClip
   {
       
      
      public var txt_amount:TextField;
      
      public function DynamiteAmountInfo_64()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         this.mouseChildren = this.mouseEnabled = false;
      }
   }
}
