package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class StackableItemAmount extends MovieClip
   {
       
      
      public var txt_amount:TextField;
      
      public function StackableItemAmount()
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
