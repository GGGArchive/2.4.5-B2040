package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class BasicComboboxItem extends MovieClip
   {
       
      
      public var bg:MovieClip;
      
      public var txt_item:TextField;
      
      public function BasicComboboxItem()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         mouseChildren = false;
      }
   }
}
