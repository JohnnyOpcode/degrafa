////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2008 Jason Hawryluk, Juan Sanchez, Andy McIntosh, Ben Stucki 
// and Pavan Podila.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
////////////////////////////////////////////////////////////////////////////////
package com.degrafa.geometry{
	
	import com.degrafa.GraphicPoint;
	import com.degrafa.IGeometry;
	import com.degrafa.core.collections.SegmentsCollection;
	import com.degrafa.geometry.segment.*;
	import com.degrafa.geometry.utilities.*;
	
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import mx.events.PropertyChangeEvent;
	
	//--------------------------------------
	//  Other metadata
	//--------------------------------------
	
	[IconFile("Path.png")]
	
	[DefaultProperty("segments")]	
	[Bindable]
	
	/**
 	*  The Path element draws a path comprised of several 
 	*  available path commands using the specified path data 
 	*  value.
 	* 
 	*  <p>Paths represent the geometry of the outline of an object, 
	*  defined in terms of moveto (set a new current point), lineto 
	*  (draw a straight line), curveto (draw a curve using a cubic Bézier), 
	*  arc (elliptical or circular arc) and closepath (close the current shape 
	*  by drawing a line to the last moveto) elements.</p>   
 	* 
 	* 
 	*  @see http://www.w3.org/TR/SVG/paths.html    
 	*  @see http://samples.degrafa.com/Path/Path.html
 	* 
 	**/
	public class Path extends Geometry implements IGeometry{
		
		/**
	 	* Constructor.
	 	*  
	 	* <p>The path constructor accepts 1 optional argument that 
	 	* defines it's segments.</p>
	 	* 
	 	* @param data A string representing 1 or more segment commands
	 	* with which to draw the path.
	 	*/	
		public function Path(data:String=null){
			super();
			
			super.data=data;
			
		}
		
		/**
		* Path short hand data value.
		* 
		* <p>The line data property expects exactly 1 value that 
		* defines the path. See below link to SVG path specification 
		* of which we follow most of.</p>
		* 
		* @see Geometry#data
		* @see http://www.w3.org/TR/SVG/paths.html
		* 
		**/	
		override public function set data(value:String):void{
			if(super.data != value){
				super.data = value;
				
				/**
				* Parse the path data using svg commands:
				* ClosePath = z
				* Moveto = M,m
				* LineTo = L,l
				* EllipticalArcTo = A,a
				* HorizontalLineTo = H,h
				* VerticalLineTo = V,v
				* Quadratic Bezier = Q,q,T,t
				* Cubic Bezier = C,c,S,s
				**/
				
				var pathDataArray:Array = PathDataToArray(value)
			
				//store the array as we add items and set the segments after 
				var segmentStack:Array=[];
				
				for (var i:int=0;i<pathDataArray.length;i++)
				{
					switch(pathDataArray[i])
					{
						
						case "L":
							segmentStack.push(new LineTo(pathDataArray[i+1],pathDataArray[i+2]));
							i+=2;
							
							//if the next item in the array is a number 
							//assume that the line is a continued array
							//so create a new line segment for each point 
							//pair until we get to another item
							if (!isNaN(Number(pathDataArray[i+1]))){
								while (!isNaN(Number(pathDataArray[i+1]))){
									segmentStack.push(new LineTo(pathDataArray[i+1],pathDataArray[i+2]));
									i+=2;
								}
							}
							
							break;
								
						case "l":
							segmentStack.push(new LineTo(pathDataArray[i+1],pathDataArray[i+2],null,"relative"));
							i+=2;
							break;
						case "h":
							segmentStack.push(new HorizontalLineTo(pathDataArray[i+1],null,"relative"));
							i+=1;
							break;
						case "H":
							segmentStack.push(new HorizontalLineTo(pathDataArray[i+1]));
							i+=1;
							break;
						case "v":
							segmentStack.push(new VerticalLineTo(pathDataArray[i+1],null,"relative"));
							i+=1;
							break;
						case "V":
							segmentStack.push(new VerticalLineTo(pathDataArray[i+1]));
							i+=1;
							break;
						case "q":
							segmentStack.push(new QuadraticBezierTo(pathDataArray[i+1],
							pathDataArray[i+2], pathDataArray[i+3],
							pathDataArray[i+4],null,"relative"));
							i += 4;
							break;
						case "Q":
							segmentStack.push(new QuadraticBezierTo(pathDataArray[i+1], 
							pathDataArray[i+2], pathDataArray[i+3], 
							pathDataArray[i+4]));
							i += 4;
							break;		
						case "t":
							segmentStack.push(new QuadraticBezierTo(0, 0,
							pathDataArray[i+1], pathDataArray[i+2],null,"relative",true))
							i += 2;
							break;
						case "T":
							segmentStack.push(new QuadraticBezierTo(0,0,
							pathDataArray[i+1], pathDataArray[i+2],null,"absolute",true))
							i += 2;
							break;
						case "c":
							segmentStack.push(new CubicBezierTo(
							pathDataArray[i+1],pathDataArray[i+2],
							pathDataArray[i+3],pathDataArray[i+4],
							pathDataArray[i+5],pathDataArray[i+6],null,"relative"))
							i += 6;
							break;
						case "C":
							segmentStack.push(new CubicBezierTo(
							pathDataArray[i+1],pathDataArray[i+2],pathDataArray[i+3],
							pathDataArray[i+4],pathDataArray[i+5],pathDataArray[i+6]))
							i += 6;
							break;
						case "s":
							segmentStack.push(new CubicBezierTo(
							0,0,pathDataArray[i+1],pathDataArray[i+2],
							pathDataArray[i+3],pathDataArray[i+4],null,"relative",true))
							i += 4;
							break;
						case "S":
							segmentStack.push(new CubicBezierTo(
							0,0,pathDataArray[i+1],pathDataArray[i+2],
							pathDataArray[i+3],pathDataArray[i+4],null,"absolute",true))
							i += 4;
							break;
						case "a":
							segmentStack.push(new EllipticalArcTo(
							pathDataArray[i+1],
							pathDataArray[i+2],
							pathDataArray[i+3],
							pathDataArray[i+4],
							pathDataArray[i+5],
							pathDataArray[i+6],
							pathDataArray[i+7],null,"relative"));
							i += 7;
							break;
						case "A":
							segmentStack.push(new EllipticalArcTo(
							pathDataArray[i+1],
							pathDataArray[i+2],
							pathDataArray[i+3],
							pathDataArray[i+4],
							pathDataArray[i+5],
							pathDataArray[i+6],
							pathDataArray[i+7]));
							i += 7;
							break;
						case "m":
							segmentStack.push(new MoveTo(pathDataArray[i+1],pathDataArray[i+2],null,"relative"));
							i += 2;
														
							//if the next item in the array is a number 
							//assume that the items are a continued array
							//of line segments so create a new line segment 
							//for each point pair until we get to another item
							if (!isNaN(Number(pathDataArray[i+1]))){
								while (!isNaN(Number(pathDataArray[i+1]))){
									segmentStack.push(new LineTo(pathDataArray[i+1],pathDataArray[i+2],null,"relative"));
									i+=2;
								}
							}
							break;
						case "M":
							segmentStack.push(new MoveTo(pathDataArray[i+1],pathDataArray[i+2]));
							i += 2;
							
							//if the next item in the array is a number 
							//assume that the items are a continued array
							//of line segments so create a new line segment 
							//for each point pair until we get to another item
							if (!isNaN(Number(pathDataArray[i+1]))){
								while (!isNaN(Number(pathDataArray[i+1]))){
									segmentStack.push(new LineTo(pathDataArray[i+1],pathDataArray[i+2]));
									i+=2;
								}
							}
							break;
						case "z":
						case "Z":
							segmentStack.push(new ClosePath());
							break;
					}
				}
			
			
				segments = segmentStack;
				invalidated = true;
				
			}
			
		} 
		
		/**
		* Converts the path data string value to an array of workable items
		**/
		private function PathDataToArray(value:String):Array{
			
			var stringToParse:String = value;
			stringToParse = stringToParse.replace(/[MmLlCcQqZzAaSsHhVvTt \- \t \n \f \s]/g,getReplaceValue);
			stringToParse = stringToParse.replace(/,,,/g,",");
			stringToParse = stringToParse.replace(/,,/g,",");
			
			return stringToParse.split(",");
			
		}
		
		/**
		* Helper function used when parsing the path data string
		**/
		private function getReplaceValue(matchedSubstring:String,itemIndex:Number,theString:String):String{	
			if (itemIndex==0){
				return matchedSubstring + ",";														
			}
			
			switch (matchedSubstring.toUpperCase()){
				case " ":
					return ",";
					break;
				case "-":
					return "," + matchedSubstring;
					break;
				default:
					return "," + matchedSubstring + ",";	
					break	
			}
						
			
		}
			
							
		private var _segments:SegmentsCollection;
		[Inspectable(category="General", arrayType="com.degrafa.geometry.segment.ISegment")]
		[ArrayElementType("com.degrafa.geometry.segment.ISegment")]
		/**
		* A array of segments that describe this path.
		**/
		public function get segments():Array{
			initSegmentsCollection();
			return _segments.items;
		}
		public function set segments(value:Array):void{
			initSegmentsCollection();
			_segments.items = value;
		}
		
		/**
		* Access to the Degrafa segment collection object for this path.
		**/
		public function get segmentCollection():SegmentsCollection{
			initSegmentsCollection();
			return _segments;
		}
		
		/**
		* Initialize the segment collection by creating it and adding the event listener.
		**/
		private function initSegmentsCollection():void{
			if(!_segments){
				_segments = new SegmentsCollection();
				
				//add a listener to the collection
				if(enableEvents){
					_segments.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,propertyChangeHandler);
				}
			}
		}
		
		/**
		* Principle event handler for any property changes to a 
		* geometry object or it's child objects.
		**/
		private function propertyChangeHandler(event:PropertyChangeEvent):void{
			dispatchEvent(event);
		}
		
		/**
		* Initialize each segment and construct an internal array of l,m,c 
		* (lineTo, moveTo, CurveTo) commands.
		**/ 
		private function buildFlashCommandStack():void{
						
			//each object hase a type l,m or c
			//keep track of the last point used during drawing
			var lastPoint:GraphicPoint = new GraphicPoint(0,0);
			
			//keep track of the first point of current 
			//path for the close command
			var firstPoint:GraphicPoint = new GraphicPoint(0,0);
						
			//store he last control point in case ShortSequence =true in 
			//which case we need to mirror the last used control point (s,S,t,T)
			var lastControlPoint:GraphicPoint=new GraphicPoint(0,0);
			
			//absolute or relative offset
			var absRelOffset:GraphicPoint = new GraphicPoint(0,0);
			
			absRelOffset.x = 0;	
   			absRelOffset.y = 0;	
									
			for (var i:int = 0;i< _segments.items.length;i++)
        	{
        		
        		var obj:Object = _segments.items[i];
        		if(ISegment(_segments.items[i]).coordinateType=="relative")
        		{
        			absRelOffset.x =lastPoint.x;
        			absRelOffset.y =lastPoint.y;
        		}
        		else
        		{
        			absRelOffset.x = 0;	
        			absRelOffset.y = 0;	
        			
        		}
        		        		
        		switch (ISegment(_segments.items[i]).segmentType)
        		{        			
        			case "LineTo":
        		
    	    			//pass the last point the abs position and the commandArray 
        				//to add the draw commands to
	        			_segments.items[i].computeSegment(lastPoint,absRelOffset,commandStack);
    	    			
    	    			lastPoint.x = absRelOffset.x+_segments.items[i].x;
	        			lastPoint.y = absRelOffset.y+_segments.items[i].y;
	        			break;
        
        			case "VerticalLineTo":
        			
        				//pass the last point the abs position and the commandStack 
        				//to add the draw commands to
	        			_segments.items[i].computeSegment(lastPoint,absRelOffset,commandStack);
        				
	        			lastPoint.y = absRelOffset.y+_segments.items[i].y;
	        			
	    				break;
        
        			case "HorizontalLineTo":
        		
        				//pass the last point the abs position and the commandStack 
        				//to add the draw commands to
	        			_segments.items[i].computeSegment(lastPoint,absRelOffset,commandStack);
	        			
	        			lastPoint.x = absRelOffset.x+_segments.items[i].x;
	    				break;
        
        			case "MoveTo":
        			
        				//pass the last point the abs position and the commandStack 
        				//to add the draw commands to
	        			_segments.items[i].computeSegment(lastPoint,absRelOffset,commandStack);
        				
        				//reset stop points
    	    			lastPoint.x = _segments.items[i].x+absRelOffset.x;
	        			lastPoint.y = _segments.items[i].y+absRelOffset.y;
        				
        				
        				firstPoint.x=_segments.items[i].x+absRelOffset.x;
        				firstPoint.y=_segments.items[i].y+absRelOffset.y;
        				        				
        				break;
        
        			case "QuadraticBezierTo":
        			
        				//pass the last point the abs position and the commandStack 
        				//to add the draw commands to, here we also need to pass the 
        				//last control point for continous bezier paths support
        				_segments.items[i].computeSegment(lastPoint,absRelOffset,lastControlPoint,commandStack);
        				
        				if(_segments.items[i].cx==0 && _segments.items[i].cy ==0
        				){
        					lastControlPoint.x = absRelOffset.x+_segments.items[i-1].cx;
	        				lastControlPoint.y = absRelOffset.y+_segments.items[i-1].cy;
        				}
        				else{
        					lastControlPoint.x = absRelOffset.x+_segments.items[i].cx;
	        				lastControlPoint.y = absRelOffset.y+_segments.items[i].cy;
	        			}
	        			       			
        				lastPoint.x = absRelOffset.x+_segments.items[i].x;
	        			lastPoint.y = absRelOffset.y+_segments.items[i].y;
	        				        			
        				break;
        
        			case "CubicBezierTo":
        			
        				//pass the last point the abs position and the commandStack 
        				//to add the draw commands to, here we also need to pass the 
        				//last control point for continous bezier paths support
        				_segments.items[i].computeSegment(lastPoint,absRelOffset,lastControlPoint,commandStack);
        				
						lastControlPoint.x = absRelOffset.x+_segments.items[i].cx1;
	        			lastControlPoint.y = absRelOffset.y+_segments.items[i].cy1;
	        			
						lastPoint.x = absRelOffset.x+_segments.items[i].x;
	        			lastPoint.y = absRelOffset.y+_segments.items[i].y;
        				
        				break;
        
        			case "EllipticalArcTo":
        			
        				//pass the last point the abs position and the commandStack 
        				//to add the draw commands to
	        		    _segments.items[i].computeSegment(lastPoint,absRelOffset,commandStack);
				    			        			
	        			lastPoint.x = _segments.items[i].x+absRelOffset.x;
	        			lastPoint.y = _segments.items[i].y+absRelOffset.y;
	        			        			
        				break;
        
        			case "ClosePath":
        				//the first point used is our close point for the path
        				//this should be in all cases the move command
        				if(firstPoint)
        				{
	        				_segments.items[i].computeSegment(lastPoint,firstPoint,commandStack);
	        				
	        			}
	        			
	        			lastPoint.x = firstPoint.x;
	        			lastPoint.y = firstPoint.y;
	        			
        				break;
        				
        		}
        	}						 		
			        	
		}
		
		private var _bounds:Rectangle;
		/**
		* The tight bounds of this element as represented by a Rectangle object. 
		**/
		override public function get bounds():Rectangle{
			return _bounds;	
		}
		
		/**
		* Calculates the bounds for this element. 
		**/				
		private function calcBounds():Rectangle{
			
			var boundsRect:Rectangle = new Rectangle();
			
			//union all segment bounds	
			for (var i:int = 0;i< _segments.items.length;i++){
        		
        		//note:: though we do calculate the moveTo segments 
        		//bounds (for other uses) we do not include them in the 
        		//tight bounds calculations for a path.
        		switch (ISegment(_segments.items[i]).segmentType){
        			case "MoveTo":
        				break;
        			
        			default:	
        				boundsRect = boundsRect.union(_segments.items[i].bounds);
        		}
        		
        	}		
        	
        	_bounds = boundsRect;
        	
        	return _bounds;
        	
		}
		
		/**
		* @inheritDoc 
		**/
		override public function preDraw():void{
			
			//see if any segments are invalide but only if we are not already invalide
			//we do this as in the case of segments with events disabled we could not 
			//know otherwise
			if(!invalidated){
				//verify
				for (var i:int=0;i<segments.length;i++){
					if(segments[i].invalidated){
						invalidated = true;
						break;
					}
				}
			}
			
			//rebuild an array of flash commands and 
			//recalculate the bounds if required	
			if(invalidated){
				commandStack.length=0;
				buildFlashCommandStack();
				calcBounds();
				invalidated = false;
			}
			
		}
				
		/**
		* Begins the draw phase for geometry objects. All geometry objects 
		* override this to do their specific rendering.
		* 
		* @param graphics The current context to draw to.
		* @param rc A Rectangle object used for fill bounds. 
		**/
		override public function draw(graphics:Graphics,rc:Rectangle):void{				
		 	//re init if required
		 	preDraw();
			super.draw(graphics,(rc)? rc:_bounds);
        }
		
		
		/**
		* An object to derive this objects properties from. When specified this 
		* object will derive it's unspecified properties from the passed object.
		**/
		public function set derive(value:Path):void{
			
			if (!fill){fill=value.fill;}
			if (!stroke){stroke = value.stroke}
			
			if (!_segments && value.segments.length!=0){
				segments = value.segments;
				invalidated = true;
			};
						
		}
		
	}
}