package MafiaInterface_fla
{
   import flash.display.MovieClip;
   
   public dynamic class AwardMC_946 extends MovieClip
   {
       
      
      public var awardtxt:MovieClip;
      
      public function AwardMC_946()
      {
         super();
         addFrameScript(140,this.frame141,499,this.frame500);
      }
      
      function frame141() : *
      {
         this.awardtxt.txt_awardmessage.text = "GOOD LUCK!";
      }
      
      function frame500() : *
      {
         gotoAndPlay("normal");
      }
   }
}
