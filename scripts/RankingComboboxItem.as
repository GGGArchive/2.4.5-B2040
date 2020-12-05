package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class RankingComboboxItem extends MovieClip
   {
       
      
      public var txt_item:TextField;
      
      public function RankingComboboxItem()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      function frame1() : *
      {
         mouseChildren = false;
      }
      
      function frame2() : *
      {
         mouseChildren = false;
      }
   }
}
