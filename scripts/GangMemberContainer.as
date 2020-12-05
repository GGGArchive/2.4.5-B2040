package
{
   import flash.display.MovieClip;
   
   public dynamic class GangMemberContainer extends MovieClip
   {
       
      
      public var holder:emptyMC;
      
      public var shadow:MovieClip;
      
      public function GangMemberContainer()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
