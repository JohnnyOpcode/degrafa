package stencils {
	import com.degrafa.geometry.stencil.Stencil;
	
	[Bindable]	
	
	public class PuzzleStencil extends Stencil{
						
		public function PuzzleStencil(){
			super();
								
			//add each item to the dictionary
			addItem("PART_001",Stencil.PATH,"M 8 4 C 11,4 10,4 12,4 C 14,4 9,8 14,8 C 19,8 14,4 16,4 C 18,4 19,4 20,4 C 20,5 20,6 20,8 C 20,10 16,5 16,10 C 16,15 20,10 20,12 C 20,14 20,15 20,16 C 19,16 18,16 16,16 C 14,16 19,12 14,12 C 9,12 14,16 12,16 C 10,16 9,16 8,16 C 8,15 8,14 8,12 C 8,10 12,15 12,10 C 12,5 8,10 8,8 C 8,6 8,5 8,4z");
			addItem("PART_002",Stencil.PATH,"M 8 4 C 11,4 10,4 12,4 C 14,4 9,8 14,8 C 19,8 14,4 16,4 C 18,4 19,4 20,4 C 20,5 20,6 20,8 C 20,10 16,5 16,10 C 16,15 20,10 20,12 C 20,14 20,15 20,16 C 19,16 18,16 16,16 C 14,16 19,12 14,12 C 9,12 14,16 12,16 C 10,16 9,16 8,16 C 8,15 8,14 8,12 C 8,10 4,15 4,10 C 4,5 8,10 8,8 C 8,6 8,5 8,4z");
			addItem("PART_003",Stencil.PATH,"M 8 4 C 11,4 10,4 12,4 C 14,4 9,8 14,8 C 19,8 14,4 16,4 C 18,4 19,4 20,4 C 20,5 20,6 20,8 C 20,10 16,5 16,10 C 16,15 20,10 20,12 C 20,14 20,15 20,16 C 19,16 18,16 16,16 C 14,16 19,20 14,20 C 9,20 14,16 12,16 C 10,16 9,16 8,16 C 8,15 8,14 8,12 C 8,10 12,15 12,10 C 12,5 8,10 8,8 C 8,6 8,5 8,4z");
			addItem("PART_004",Stencil.PATH,"M 8 4 C 11,4 10,4 12,4 C 14,4 9,8 14,8 C 19,8 14,4 16,4 C 18,4 19,4 20,4 C 20,5 20,6 20,8 C 20,10 16,5 16,10 C 16,15 20,10 20,12 C 20,14 20,15 20,16 C 19,16 18,16 16,16 C 14,16 19,20 14,20 C 9,20 14,16 12,16 C 10,16 9,16 8,16 C 8,15 8,14 8,12 C 8,10 4,15 4,10 C 4,5 8,10 8,8 C 8,6 8,5 8,4z");
			addItem("PART_005",Stencil.PATH,"M 8 4 C 11,4 10,4 12,4 C 14,4 9,8 14,8 C 19,8 14,4 16,4 C 18,4 19,4 20,4 C 20,5 20,6 20,8 C 20,10 24,5 24,10 C 24,15 20,10 20,12 C 20,14 20,15 20,16 C 19,16 18,16 16,16 C 14,16 19,12 14,12 C 9,12 14,16 12,16 C 10,16 9,16 8,16 C 8,15 8,14 8,12 C 8,10 12,15 12,10 C 12,5 8,10 8,8 C 8,6 8,5 8,4z");
			addItem("PART_006",Stencil.PATH,"M 8 4 C 11,4 10,4 12,4 C 14,4 9,8 14,8 C 19,8 14,4 16,4 C 18,4 19,4 20,4 C 20,5 20,6 20,8 C 20,10 24,5 24,10 C 24,15 20,10 20,12 C 20,14 20,15 20,16 C 19,16 18,16 16,16 C 14,16 19,12 14,12 C 9,12 14,16 12,16 C 10,16 9,16 8,16 C 8,15 8,14 8,12 C 8,10 4,15 4,10 C 4,5 8,10 8,8 C 8,6 8,5 8,4z");
			addItem("PART_007",Stencil.PATH,"M 8 4 C 11,4 10,4 12,4 C 14,4 9,8 14,8 C 19,8 14,4 16,4 C 18,4 19,4 20,4 C 20,5 20,6 20,8 C 20,10 24,5 24,10 C 24,15 20,10 20,12 C 20,14 20,15 20,16 C 19,16 18,16 16,16 C 14,16 19,20 14,20 C 9,20 14,16 12,16 C 10,16 9,16 8,16 C 8,15 8,14 8,12 C 8,10 12,15 12,10 C 12,5 8,10 8,8 C 8,6 8,5 8,4z");
			addItem("PART_008",Stencil.PATH,"M 8 4 C 11,4 10,4 12,4 C 14,4 9,8 14,8 C 19,8 14,4 16,4 C 18,4 19,4 20,4 C 20,5 20,6 20,8 C 20,10 24,5 24,10 C 24,15 20,10 20,12 C 20,14 20,15 20,16 C 19,16 18,16 16,16 C 14,16 19,20 14,20 C 9,20 14,16 12,16 C 10,16 9,16 8,16 C 8,15 8,14 8,12 C 8,10 4,15 4,10 C 4,5 8,10 8,8 C 8,6 8,5 8,4z");
			addItem("PART_009",Stencil.PATH,"M 8 4 C 11,4 10,4 12,4 C 14,4 9,0 14,0 C 19,0 14,4 16,4 C 18,4 19,4 20,4 C 20,5 20,6 20,8 C 20,10 16,5 16,10 C 16,15 20,10 20,12 C 20,14 20,15 20,16 C 19,16 18,16 16,16 C 14,16 19,12 14,12 C 9,12 14,16 12,16 C 10,16 9,16 8,16 C 8,15 8,14 8,12 C 8,10 12,15 12,10 C 12,5 8,10 8,8 C 8,6 8,5 8,4z");
			addItem("PART_010",Stencil.PATH,"M 8 4 C 11,4 10,4 12,4 C 14,4 9,0 14,0 C 19,0 14,4 16,4 C 18,4 19,4 20,4 C 20,5 20,6 20,8 C 20,10 16,5 16,10 C 16,15 20,10 20,12 C 20,14 20,15 20,16 C 19,16 18,16 16,16 C 14,16 19,12 14,12 C 9,12 14,16 12,16 C 10,16 9,16 8,16 C 8,15 8,14 8,12 C 8,10 4,15 4,10 C 4,5 8,10 8,8 C 8,6 8,5 8,4z");
			addItem("PART_011",Stencil.PATH,"M 8 4 C 11,4 10,4 12,4 C 14,4 9,0 14,0 C 19,0 14,4 16,4 C 18,4 19,4 20,4 C 20,5 20,6 20,8 C 20,10 16,5 16,10 C 16,15 20,10 20,12 C 20,14 20,15 20,16 C 19,16 18,16 16,16 C 14,16 19,20 14,20 C 9,20 14,16 12,16 C 10,16 9,16 8,16 C 8,15 8,14 8,12 C 8,10 12,15 12,10 C 12,5 8,10 8,8 C 8,6 8,5 8,4z");
			addItem("PART_012",Stencil.PATH,"M 8 4 C 11,4 10,4 12,4 C 14,4 9,0 14,0 C 19,0 14,4 16,4 C 18,4 19,4 20,4 C 20,5 20,6 20,8 C 20,10 16,5 16,10 C 16,15 20,10 20,12 C 20,14 20,15 20,16 C 19,16 18,16 16,16 C 14,16 19,20 14,20 C 9,20 14,16 12,16 C 10,16 9,16 8,16 C 8,15 8,14 8,12 C 8,10 4,15 4,10 C 4,5 8,10 8,8 C 8,6 8,5 8,4z");
			addItem("PART_013",Stencil.PATH,"M 8 4 C 11,4 10,4 12,4 C 14,4 9,0 14,0 C 19,0 14,4 16,4 C 18,4 19,4 20,4 C 20,5 20,6 20,8 C 20,10 24,5 24,10 C 24,15 20,10 20,12 C 20,14 20,15 20,16 C 19,16 18,16 16,16 C 14,16 19,12 14,12 C 9,12 14,16 12,16 C 10,16 9,16 8,16 C 8,15 8,14 8,12 C 8,10 12,15 12,10 C 12,5 8,10 8,8 C 8,6 8,5 8,4z");
			addItem("PART_014",Stencil.PATH,"M 8 4 C 11,4 10,4 12,4 C 14,4 9,0 14,0 C 19,0 14,4 16,4 C 18,4 19,4 20,4 C 20,5 20,6 20,8 C 20,10 24,5 24,10 C 24,15 20,10 20,12 C 20,14 20,15 20,16 C 19,16 18,16 16,16 C 14,16 19,12 14,12 C 9,12 14,16 12,16 C 10,16 9,16 8,16 C 8,15 8,14 8,12 C 8,10 4,15 4,10 C 4,5 8,10 8,8 C 8,6 8,5 8,4z");
			addItem("PART_015",Stencil.PATH,"M 8 4 C 11,4 10,4 12,4 C 14,4 9,0 14,0 C 19,0 14,4 16,4 C 18,4 19,4 20,4 C 20,5 20,6 20,8 C 20,10 24,5 24,10 C 24,15 20,10 20,12 C 20,14 20,15 20,16 C 19,16 18,16 16,16 C 14,16 19,20 14,20 C 9,20 14,16 12,16 C 10,16 9,16 8,16 C 8,15 8,14 8,12 C 8,10 12,15 12,10 C 12,5 8,10 8,8 C 8,6 8,5 8,4z");
			addItem("PART_016",Stencil.PATH,"M 8 4 C 11,4 10,4 12,4 C 14,4 9,0 14,0 C 19,0 14,4 16,4 C 18,4 19,4 20,4 C 20,5 20,6 20,8 C 20,10 24,5 24,10 C 24,15 20,10 20,12 C 20,14 20,15 20,16 C 19,16 18,16 16,16 C 14,16 19,20 14,20 C 9,20 14,16 12,16 C 10,16 9,16 8,16 C 8,15 8,14 8,12 C 8,10 4,15 4,10 C 4,5 8,10 8,8 C 8,6 8,5 8,4z");
			
		}
				
		[Inspectable(category="General", 
		enumeration="PART_001,PART_002,PART_003,PART_004,PART_005,PART_006,PART_007,PART_008,PART_009,PART_010,PART_011,PART_012,PART_013,PART_014,PART_015,PART_016",				
		defaultValue="PART_001")]
		override public function set type(value:String):void{
			super.type=value;
		}
	}
}