import action_alert.HAlert;
import action_alert.HMensagens;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.FileReference;
import flash.net.URLRequest;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.events.Request;

public var fileRefScript_mininet:FileReference;// = new FileReference();

public function exportMininetScriptFile():void {
	var objSend:Object = new Object;
	var temp_mininet:ArrayCollection=new ArrayCollection();
	var objeto_mininet:Object=new Object();
	var cont_mininet:int=0;
	var expo:Boolean=true;	
	var computerMask:String;	
	var computerIPAddress:String;
	var arrayStationPassword:String;
	var arrayStationSSID:String;
	var computerMacAddress:String;
	var controllerPort:String;
	var countControllerSource:String;
	var countControllerDestination:String;
	var countSwitchSource:String;
	var countSwitchDestination:String;
	var storeSwitches:Array=[];
	var storeConnectivity:Array=[];
	var exists:Boolean=false;
	var controllerIPAddress:String;
	var urlRequest:URLRequest;
	var ab:int;
	var p:int;
	var i:int;
	var ir:int;
	var isWireless:Boolean=false;
	var nRadios:int=0;
	//CHECK VALUES
	//----------------------------------------------------------------------
	for(p=0;p<dropCanvas.numChildren;p++){	
		var UIob:Object = dropCanvas.getChildAt(p);
		if(UIob.className =='objects'){
			var ob:objects=UIob as objects;		
			var obb:Object=ob;
			for(ir=0;ir<(obb.objparaArrayCol.length);ir++){
				obj=obb.objparaArrayCol[ir] as objParameter;
				if(ob.id=="computer"){
					ab = int(ob.name.slice(9,11));
					ye=ab;
				}
				//else if(ob.id=="switchOpenflow"){
				//	ab = int(ob.name.slice(15,17));
				//	ye=ab;
				//}
				else if(ob.id=="wirelessRouter"||ob.id=="switchOpenflow"){
					ab = int(ob.name.slice(15,17));
					ye=ab;													
					if(obj.name=="switch"){	
						switch_ = obj.arraySwitch;	
					}	
					if(switch_=="user")
						switch_="UserSwitch"
					else if(switch_=="ovsk")
						switch_="OVSKernelSwitch"
					else if(switch_=="ovsl")
						switch_="OVSLegacyKernelSwitch"
					else if(switch_=="ivs")
						switch_="IVSSwitch"
					else
						switch_="OVSKernelSwitch"
				}
				else if(ob.id=="controllerOpenflow"){
					ab = int(ob.name.slice(19,21));
					ye=ab;
				}
			}
		}
	}
	//----------------------------------------------------------------------
	
	cont_mininet++;
	sh = "#!/usr/bin/python@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "\n\"\"\"@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "Script created by VND - Visual Network Description (SDN version)@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "\"\"\"@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "from mininet.net import Mininet@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "from mininet.node import Controller, RemoteController, OVSKernelSwitch, UserSwitch@@";
	//sh = "from mininet.node import Controller, RemoteController, OVSKernelSwitch, IVSSwitch, OVSLegacyKernelSwitch, UserSwitch@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "from mininet.cli import CLI@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "from mininet.log import setLogLevel@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "from mininet.link import Link, TCLink@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "def topology():@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "    \"Create a network.\"@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	
	
	for(p=0;p<dropCanvas.numChildren;p++){			
		UIob = dropCanvas.getChildAt(p);
		if(UIob.className =='objects'){
			ob=UIob as objects;	
			obb=ob;
			if(ob.isMOtherTemplate==true ||ob.isChildTemplatedOne!=true ){
				//cont_mininet++;
				if(ob.id=="station"||ob.id=="wirelessRouter"){
					isWireless=true;
					nRadios=nRadios+1;
				}
			}
		}
	}
	
	if(isWireless){
		cont_mininet++;
		nRadios=nRadios+1;
		sh = "    net = Mininet( wirelessRadios="+nRadios+", controller=RemoteController, link=TCLink, switch="+switch_+" )@@";
		objeto_mininet=sh;
		temp_mininet.addItem(objeto_mininet);
	}
	else{
		cont_mininet++;
		sh = "    net = Mininet( controller=RemoteController, link=TCLink, switch="+switch_+" )@@";
		objeto_mininet=sh;
		temp_mininet.addItem(objeto_mininet);
	}
		
		
	//----------------------------------------------------------------------
	//----------------------------------------------------------------------
	
	for(p=0;p<dropCanvas.numChildren;p++){	
		intnew=1;
		if(p==0){
			cont_mininet++;
			sh = "@@";
			objeto_mininet=sh;
			cont_mininet++;
			temp_mininet.addItem(objeto_mininet);
			sh = "    print \"*** Creating nodes\"@@";
			objeto_mininet=sh;
			temp_mininet.addItem(objeto_mininet);
		}
		UIob = dropCanvas.getChildAt(p);
		if(UIob.className =='objects'){
			ob=UIob as objects;	
			obb=ob;
			if(ob.isMOtherTemplate==true ||ob.isChildTemplatedOne!=true ){
				//cont_mininet++;
				if(ob.id=="station"){
					ab = int(ob.name.slice(8,10));
					ye=ab;													
					for(i=0;i<(obb.objparaArrayCol.length);i++){
						var obj:objParameter=obb.objparaArrayCol[i] as objParameter;
					}		
					for(ir=0;ir<(obb.objparaArrayCol.length);ir++){
						obj=obb.objparaArrayCol[ir] as objParameter;									
						if(obj.name=="stationIPAddress"){												
							computerIPAddress = obj.arrayComputerIPAddress1[ye];
						}	
						else if(obj.name=="stationMacAddress"){												
							computerMacAddress = obj.arrayComputerMacAddress1[ye];
						}
						else if(obj.name=="stationSSID"){												
							arrayStationSSID = obj.arrayStationSSID1[ye];
						}
						else if(obj.name=="stationpassword"){												
							arrayStationPassword = obj.arrayStationPassword1[ye];
						}
						else if(obj.name=="mask"){												
							computerMask = obj.arrayComputerMask[ye];
							if(computerMask=="255.0.0.0")
								computerMask="8";
							else if(computerMask=="255.128.0.0")
								computerMask="9";
							else if(computerMask=="255.192.0.0")
								computerMask="10";
							else if(computerMask=="255.224.0.0")
								computerMask="11";
							else if(computerMask=="255.240.0.0")
								computerMask="12";
							else if(computerMask=="255.248.0.0")
								computerMask="13";
							else if(computerMask=="255.252.0.0")
								computerMask="14";
							else if(computerMask=="255.254.0.0")
								computerMask="15";
							else if(computerMask=="255.255.0.0")
								computerMask="16";
							else if(computerMask=="255.255.128.0")
								computerMask="17";
							else if(computerMask=="255.255.192.0")
								computerMask="18";
							else if(computerMask=="255.255.224.0")
								computerMask="19";
							else if(computerMask=="255.255.240.0")
								computerMask="20";
							else if(computerMask=="255.255.248.0")
								computerMask="21";
							else if(computerMask=="255.255.252.0")
								computerMask="22";
							else if(computerMask=="255.255.254.0")
								computerMask="23";
							else if(computerMask=="255.255.255.0")
								computerMask="24";
							else if(computerMask=="255.255.255.128")
								computerMask="25";
							else if(computerMask=="255.255.255.192")
								computerMask="26";
							else if(computerMask=="255.255.255.224")
								computerMask="27";
							else if(computerMask=="255.255.255.240")
								computerMask="28";
							else if(computerMask=="255.255.255.248")
								computerMask="29";
							else if(computerMask=="255.255.255.252")
								computerMask="30";
						}										
					}
					cont_mininet++;
					sh = "    sta"+ob.name.slice(8,10)+" = net.addStation( 'sta"+ob.name.slice(8,10)+"' )@@";
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);
				}
				if(ob.id=="computer"){
					ab = int(ob.name.slice(9,11));
					ye=ab;													
					for(i=0;i<(obb.objparaArrayCol.length);i++){
						obj=obb.objparaArrayCol[i] as objParameter;
					}		
					for(ir=0;ir<(obb.objparaArrayCol.length);ir++){
						obj=obb.objparaArrayCol[ir] as objParameter;									
						if(obj.name=="computerIPAddress"){												
							computerIPAddress = obj.arrayComputerIPAddress1[ye];
						}	
						else if(obj.name=="computerMacAddress"){												
							computerMacAddress = obj.arrayComputerMacAddress1[ye];
						}	
						else if(obj.name=="mask"){												
							computerMask = obj.arrayComputerMask[ye];
							if(computerMask=="255.0.0.0")
								computerMask="8";
							else if(computerMask=="255.128.0.0")
								computerMask="9";
							else if(computerMask=="255.192.0.0")
								computerMask="10";
							else if(computerMask=="255.224.0.0")
								computerMask="11";
							else if(computerMask=="255.240.0.0")
								computerMask="12";
							else if(computerMask=="255.248.0.0")
								computerMask="13";
							else if(computerMask=="255.252.0.0")
								computerMask="14";
							else if(computerMask=="255.254.0.0")
								computerMask="15";
							else if(computerMask=="255.255.0.0")
								computerMask="16";
							else if(computerMask=="255.255.128.0")
								computerMask="17";
							else if(computerMask=="255.255.192.0")
								computerMask="18";
							else if(computerMask=="255.255.224.0")
								computerMask="19";
							else if(computerMask=="255.255.240.0")
								computerMask="20";
							else if(computerMask=="255.255.248.0")
								computerMask="21";
							else if(computerMask=="255.255.252.0")
								computerMask="22";
							else if(computerMask=="255.255.254.0")
								computerMask="23";
							else if(computerMask=="255.255.255.0")
								computerMask="24";
							else if(computerMask=="255.255.255.128")
								computerMask="25";
							else if(computerMask=="255.255.255.192")
								computerMask="26";
							else if(computerMask=="255.255.255.224")
								computerMask="27";
							else if(computerMask=="255.255.255.240")
								computerMask="28";
							else if(computerMask=="255.255.255.248")
								computerMask="29";
							else if(computerMask=="255.255.255.252")
								computerMask="30";
						}										
					}
					cont_mininet++;
					sh = "    h"+ob.name.slice(9,11)+" = net.addHost( 'h"+ob.name.slice(9,11)+"', mac='"+computerMacAddress+"', ip='"+computerIPAddress+"/"+computerMask+"' )@@";
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);
				}
				else if(ob.id=="switchOpenflow"){
					ab = int(ob.name.slice(15,17));
					ye=ab;
					for(i=0;i<(obb.objparaArrayCol.length);i++){
						obj=obb.objparaArrayCol[i] as objParameter;
					}		
					for(ir=0;ir<(obb.objparaArrayCol.length);ir++){
						obj=obb.objparaArrayCol[ir] as objParameter;									
						if(obj.name=="switchMacAddress"){	
							macSwitch = obj.arrayMacSwitch1[ye];
						}	
						else if(obj.name=="listeningPort"){	
							listenPortSwitch = obj.arrayListenPortSwitch1[ye];
						}
						else if(obj.name=="ofp_version"){	
							openFlowVersion = obj.arrayOpenFlowVersion[ye];
						}
					}
					cont_mininet++;
					if(openFlowVersion==null||openFlowVersion=="")
						sh = "    s"+ob.name.slice(15,17)+" = net.addSwitch( 's"+ob.name.slice(15,17)+"', listenPort="+listenPortSwitch+", mac='"+macSwitch+"' )@@";
					else if(openFlowVersion=="1")
						sh = "    s"+ob.name.slice(15,17)+" = net.addSwitch( 's"+ob.name.slice(15,17)+"', protocols='OpenFlow10', listenPort="+listenPortSwitch+", mac='"+macSwitch+"' )@@";
					else if(openFlowVersion=="1.1")
						sh = "    s"+ob.name.slice(15,17)+" = net.addSwitch( 's"+ob.name.slice(15,17)+"', protocols='OpenFlow11', listenPort="+listenPortSwitch+", mac='"+macSwitch+"' )@@";
					else if(openFlowVersion=="1.2")
						sh = "    s"+ob.name.slice(15,17)+" = net.addSwitch( 's"+ob.name.slice(15,17)+"', protocols='OpenFlow12', listenPort="+listenPortSwitch+", mac='"+macSwitch+"' )@@";
					else if(openFlowVersion=="1.3")
						sh = "    s"+ob.name.slice(15,17)+" = net.addSwitch( 's"+ob.name.slice(15,17)+"', protocols='OpenFlow13', listenPort="+listenPortSwitch+", mac='"+macSwitch+"' )@@";
					else if(openFlowVersion=="1.4")
						sh = "    s"+ob.name.slice(15,17)+" = net.addSwitch( 's"+ob.name.slice(15,17)+"', protocols='OpenFlow14', listenPort="+listenPortSwitch+", mac='"+macSwitch+"' )@@";
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);
				}		
				else if(ob.id=="wirelessRouter"){
					ab = int(ob.name.slice(15,17));
					ye=ab;
					for(i=0;i<(obb.objparaArrayCol.length);i++){
						obj=obb.objparaArrayCol[i] as objParameter;
					}		
					for(ir=0;ir<(obb.objparaArrayCol.length);ir++){
						obj=obb.objparaArrayCol[ir] as objParameter;									
						if(obj.name=="switchMacAddress"){	
							macSwitch = obj.arrayMacSwitch1[ye];
						}	
						else if(obj.name=="listeningPort"){	
							listenPortSwitch = obj.arrayListenPortSwitch1[ye];
						}
						else if(obj.name=="ofp_version"){	
							openFlowVersion = obj.arrayOpenFlowVersion[ye];
						}
						else if(obj.name=="routerSSID"){	
							routerSSID = obj.arrayRouterSSID1[ye];
						}
						else if(obj.name=="mode"){	
							mode = obj.arrayGetMode[ye];
						}
						else if(obj.name=="channel"){	
							channel = obj.arrayGetChannel[ye];
						}
					}
					cont_mininet++;
					if(openFlowVersion==null||openFlowVersion=="")
						sh = "    s"+ob.name.slice(15,17)+" = net.addBaseStation( 's"+ob.name.slice(15,17)+"', ssid= '"+routerSSID+"', mode= '"+mode+"', channel= '"+channel+"' )@@";
					else if(openFlowVersion=="1")
						sh = "    s"+ob.name.slice(15,17)+" = net.addBaseStation( 's"+ob.name.slice(15,17)+"', ssid= '"+routerSSID+"', mode= '"+mode+"', channel= '"+channel+"' )@@";
					else if(openFlowVersion=="1.1")
						sh = "    s"+ob.name.slice(15,17)+" = net.addBaseStation( 's"+ob.name.slice(15,17)+"', ssid= '"+routerSSID+"', mode= '"+mode+"', channel= '"+channel+"' )@@";
					else if(openFlowVersion=="1.2")
						sh = "    s"+ob.name.slice(15,17)+" = net.addBaseStation( 's"+ob.name.slice(15,17)+"', ssid= '"+routerSSID+"', mode= '"+mode+"', channel= '"+channel+"' )@@";
					else if(openFlowVersion=="1.3")
						sh = "    s"+ob.name.slice(15,17)+" = net.addBaseStation( 's"+ob.name.slice(15,17)+"', ssid= '"+routerSSID+"', mode= '"+mode+"', channel= '"+channel+"' )@@";
					else if(openFlowVersion=="1.4")
						sh = "    s"+ob.name.slice(15,17)+" = net.addBaseStation( 's"+ob.name.slice(15,17)+"', ssid= '"+routerSSID+"', mode= '"+mode+"', channel= '"+channel+"' )@@";
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);
				}
				else if(ob.id=="controllerOpenflow"){		
					ab = int(ob.name.slice(19,21));
					ye=ab;
					for(i=0;i<(obb.objparaArrayCol.length);i++){
						obj=obb.objparaArrayCol[i] as objParameter;
					}		
					for(ir=0;ir<(obb.objparaArrayCol.length);ir++){
						obj=obb.objparaArrayCol[ir] as objParameter;
						
						if(obj.name=="controllerIPAddress"){												
							controllerIPAddress = obj.arrayControllerIPAddress[ye][0];	
						}											
						else if(obj.name=="controllerPort"){
							controllerPort = obj.arrayControllerPort[ye];	
						}	
					}					
					cont_mininet++;
					sh = "    c"+ob.name.slice(19,21)+" = net.addController( 'c"+ob.name.slice(19,21)+"', controller=RemoteController, ip='"+controllerIPAddress+"', port="+controllerPort+" )@@";
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);
				}
			}
		} 
	}	
	//----------------------------------------------------------------------
	//----------------------------------------------------------------------
	for(var j:int=0;j<dropCanvas.numChildren;j++){	
		if(j==0){
			cont_mininet++;
			sh = "@@";
			objeto_mininet=sh;
			temp_mininet.addItem(objeto_mininet);
			cont_mininet++;
			sh = "    print \"*** Creating links\"@@";
			objeto_mininet=sh;
			temp_mininet.addItem(objeto_mininet);
		}
		UIob = dropCanvas.getChildAt(j);
		if(UIob.className=='Link'){
			var obLink:Link=UIob as Link;
			if(obLink.can.lineName=="wireless"||obLink.can.lineName=="fiber"||obLink.can.lineName=="ethernet"){		
				if(obLink.can.isMOtherTemplate==true || obLink.can.isChildTemplatedOne!=true ){		
				if((obLink.can.source.name.slice(0,14)=="switchOpenflow"||obLink.can.source.name.slice(0,14)=="wirelessRouter")&&(obLink.can.destination.name.slice(0,14)=="switchOpenflow"||obLink.can.destination.name.slice(0,14)=="wirelessRouter")){
					cont_mininet++;
					sh = "    net.addLink(s"+obLink.can.source.name.slice(15,17)+", s"+obLink.can.destination.name.slice(15,17)+", "+obLink.can.sourcePort+", "+obLink.can.destinationPort+",";
					
					if(obLink.can.bw!=null&&obLink.can.bw!="default")
						sh=sh.concat(" bw="+obLink.can.bw+",");	
					if(obLink.can.delay!=""&&obLink.can.delay!=null)
						sh=sh.concat(" delay='"+obLink.can.delay+"ms',");	
					if(obLink.can.maxqueuesize!=""&&obLink.can.maxqueuesize!=null)
						sh=sh.concat(" max_queue_size="+obLink.can.maxqueuesize+",");
					if(obLink.can.loss!=""&&obLink.can.loss!=null)
						sh=sh.concat(" loss="+obLink.can.loss+",");
					if(obLink.can.htb=="True")
						sh=sh.concat(" use_htb="+obLink.can.htb+",");
					
					sh=sh.substring(0, sh.length-1);
					sh=sh.concat(")@@");
					
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);
				}
				else if((obLink.can.source.name.slice(0,14)=="switchOpenflow"||obLink.can.source.name.slice(0,14)=="wirelessRouter")||(obLink.can.destination.name.slice(0,14)=="switchOpenflow"||obLink.can.destination.name.slice(0,14)=="wirelessRouter")){
					if(obLink.can.source.name.slice(0,8)=="computer"){
						cont_mininet++;
						sh = "    net.addLink(h"+obLink.can.source.name.slice(9,11)+", s"+obLink.can.destination.name.slice(15,17)+", "+0+", "+obLink.can.destinationPort+",";
						if(obLink.can.bw!=null&&obLink.can.bw!="default")
							sh=sh.concat(" bw="+obLink.can.bw+",");	
						if(obLink.can.delay!=""&&obLink.can.delay!=null)
							sh=sh.concat(" delay='"+obLink.can.delay+"ms',");	
						if(obLink.can.maxqueuesize!=""&&obLink.can.maxqueuesize!=null)
							sh=sh.concat(" max_queue_size="+obLink.can.maxqueuesize+",");
						if(obLink.can.loss!=""&&obLink.can.loss!=null)
							sh=sh.concat(" loss="+obLink.can.loss+",");
						if(obLink.can.htb=="True")
							sh=sh.concat(" use_htb="+obLink.can.htb+",");
						
						sh=sh.substring(0, sh.length-1);
						sh=sh.concat(")@@");
						
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);
					}
					else if(obLink.can.source.name.slice(0,7)=="station"){
						cont_mininet++;
						sh = "    net.addLink(sta"+obLink.can.source.name.slice(8,10)+", s"+obLink.can.destination.name.slice(15,17)+",";
						sh=sh.substring(0, sh.length-1);
						sh=sh.concat(")@@");
						
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);
					}
					else if (obLink.can.destination.name.slice(0,8)=="computer"){
						cont_mininet++;
						sh = "    net.addLink(s"+obLink.can.source.name.slice(15,17)+", h"+obLink.can.destination.name.slice(9,11)+", "+obLink.can.sourcePort+", "+0+",";
						
						if(obLink.can.bw!=null&&obLink.can.bw!="default")
							sh=sh.concat(" bw="+obLink.can.bw+",");	
						if(obLink.can.delay!=""&&obLink.can.delay!=null)
							sh=sh.concat(" delay='"+obLink.can.delay+"ms',");	
						if(obLink.can.maxqueuesize!=""&&obLink.can.maxqueuesize!=null)
							sh=sh.concat(" max_queue_size="+obLink.can.maxqueuesize+",");
						if(obLink.can.loss!=""&&obLink.can.loss!=null)
							sh=sh.concat(" loss="+obLink.can.loss+",");
						if(obLink.can.htb=="True")
							sh=sh.concat(" use_htb="+obLink.can.htb+",");
						
						sh=sh.substring(0, sh.length-1);
						sh=sh.concat(")@@");
						
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);
					}
					else if (obLink.can.destination.name.slice(0,7)=="station"){
						cont_mininet++;
						sh = "    net.addLink(s"+obLink.can.source.name.slice(15,17)+", sta"+obLink.can.destination.name.slice(8,10)+",";
						sh=sh.substring(0, sh.length-1);
						sh=sh.concat(")@@");
						
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);
					}
				}	
				else if((obLink.can.source.name.slice(0,8)=="computer"&&(obLink.can.destination.name.slice(0,8)=="computer"))){
						cont_mininet++;
						sh = "    net.addLink(h"+obLink.can.source.name.slice(9,11)+", h"+obLink.can.destination.name.slice(9,11)+",";
						if(obLink.can.bw!=null&&obLink.can.bw!="default")
							sh=sh.concat(" bw="+obLink.can.bw+",");	
						if(obLink.can.delay!=""&&obLink.can.delay!=null)
							sh=sh.concat(" delay='"+obLink.can.delay+"ms',");	
						if(obLink.can.maxqueuesize!=""&&obLink.can.maxqueuesize!=null)
							sh=sh.concat(" max_queue_size="+obLink.can.maxqueuesize+",");
						if(obLink.can.loss!=""&&obLink.can.loss!=null)
							sh=sh.concat(" loss="+obLink.can.loss+",");
						if(obLink.can.htb=="True")
							sh=sh.concat(" use_htb="+obLink.can.htb+",");
						
						sh=sh.substring(0, sh.length-1);
						sh=sh.concat(")@@");
						
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);				
				}
				else if((obLink.can.source.name.slice(0,7)=="station"&&(obLink.can.destination.name.slice(0,7)=="station"))){
					cont_mininet++;
					sh = "    net.addLink(sta"+obLink.can.source.name.slice(8,10)+", sta"+obLink.can.destination.name.slice(8,10)+",";
					sh=sh.substring(0, sh.length-1);
					sh=sh.concat(")@@");
					
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);				
				}
			}
			else if(obLink.can.isChildTemplatedOne==true){
				if((obLink.can.source.name.slice(0,14)=="switchOpenflow"||obLink.can.source.name.slice(0,14)=="wirelessRouter")&&(obLink.can.destination.name.slice(0,14)=="switchOpenflow"||obLink.can.destination.name.slice(0,14)=="wirelessRouter")){
					cont_mininet++;
					sh = "    net.addLink(s"+obLink.can.source.name.slice(15,17)+", s"+obLink.can.destination.name.slice(15,17)+", "+obLink.can.sourcePort+", "+obLink.can.destinationPort+",";
					
					if(obLink.can.bw!=null&&obLink.can.bw!="default")
						sh=sh.concat(" bw="+obLink.can.bw+",");	
					if(obLink.can.delay!=""&&obLink.can.delay!=null)
						sh=sh.concat(" delay='"+obLink.can.delay+"ms',");	
					if(obLink.can.maxqueuesize!=""&&obLink.can.maxqueuesize!=null)
						sh=sh.concat(" max_queue_size="+obLink.can.maxqueuesize+",");
					if(obLink.can.loss!=""&&obLink.can.loss!=null)
						sh=sh.concat(" loss="+obLink.can.loss+",");
					if(obLink.can.htb=="True")
						sh=sh.concat(" use_htb="+obLink.can.htb+",");
					
					sh=sh.substring(0, sh.length-1);
					sh=sh.concat(")@@");
					
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);								
				}
				else if((obLink.can.source.name.slice(0,14)=="switchOpenflow"||obLink.can.source.name.slice(0,14)=="wirelessRouter")||(obLink.can.destination.name.slice(0,14)=="switchOpenflow"||obLink.can.destination.name.slice(0,14)=="wirelessRouter")){
					cont_mininet++;
					if(obLink.can.source.name.slice(0,8)=="computer"){
						cont_mininet++;
						sh = "    net.addLink(h"+obLink.can.source.name.slice(9,11)+", s"+obLink.can.destination.name.slice(15,17)+", "+0+", "+obLink.can.destinationPort+",";
						
						if(obLink.can.bw!=null&&obLink.can.bw!="default")
							sh=sh.concat(" bw="+obLink.can.bw+",");	
						if(obLink.can.delay!=""&&obLink.can.delay!=null)
							sh=sh.concat(" delay='"+obLink.can.delay+"ms',");	
						if(obLink.can.maxqueuesize!=""&&obLink.can.maxqueuesize!=null)
							sh=sh.concat(" max_queue_size="+obLink.can.maxqueuesize+",");
						if(obLink.can.loss!=""&&obLink.can.loss!=null)
							sh=sh.concat(" loss="+obLink.can.loss+",");
						if(obLink.can.htb=="True")
							sh=sh.concat(" use_htb="+obLink.can.htb+",");
						
						sh=sh.substring(0, sh.length-1);
						sh=sh.concat(")@@");
						
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);
					}
					else if(obLink.can.source.name.slice(0,7)=="station"){
						cont_mininet++;
						sh = "    net.addLink(sta"+obLink.can.source.name.slice(8,10)+", s"+obLink.can.destination.name.slice(15,17)+",";
						sh=sh.substring(0, sh.length-1);
						sh=sh.concat(")@@");
						
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);
					}
					else if (obLink.can.destination.name.slice(0,8)=="computer"){
						cont_mininet++;
						sh = "    net.addLink(s"+obLink.can.source.name.slice(15,17)+", h"+obLink.can.destination.name.slice(9,11)+", "+obLink.can.sourcePort+", "+0+",";
						
						if(obLink.can.bw!=null&&obLink.can.bw!="default")
							sh=sh.concat(" bw="+obLink.can.bw+",");	
						if(obLink.can.delay!=""&&obLink.can.delay!=null)
							sh=sh.concat(" delay='"+obLink.can.delay+"ms',");	
						if(obLink.can.maxqueuesize!=""&&obLink.can.maxqueuesize!=null)
							sh=sh.concat(" max_queue_size="+obLink.can.maxqueuesize+",");
						if(obLink.can.loss!=""&&obLink.can.loss!=null)
							sh=sh.concat(" loss="+obLink.can.loss+",");
						if(obLink.can.htb=="True")
							sh=sh.concat(" use_htb="+obLink.can.htb+",");
						
						sh=sh.substring(0, sh.length-1);
						sh=sh.concat(")@@");
						
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);
					}
					else if (obLink.can.destination.name.slice(0,7)=="station"){
						cont_mininet++;
						sh = "    net.addLink(s"+obLink.can.source.name.slice(15,17)+", sta"+obLink.can.destination.name.slice(8,10)+",";
						sh=sh.substring(0, sh.length-1);
						sh=sh.concat(")@@");
						
						objeto_mininet=sh;
						temp_mininet.addItem(objeto_mininet);
					}
				}	
				else if((obLink.can.source.name.slice(0,8)=="computer"&&(obLink.can.destination.name.slice(0,8)=="computer"))){
					cont_mininet++;
					sh = "    net.addLink(h"+obLink.can.source.name.slice(9,11)+", h"+obLink.can.destination.name.slice(9,11)+",";
					if(obLink.can.bw!=null&&obLink.can.bw!="default")
						sh=sh.concat(" bw="+obLink.can.bw+",");	
					if(obLink.can.delay!=""&&obLink.can.delay!=null)
						sh=sh.concat(" delay='"+obLink.can.delay+"ms',");	
					if(obLink.can.maxqueuesize!=""&&obLink.can.maxqueuesize!=null)
						sh=sh.concat(" max_queue_size="+obLink.can.maxqueuesize+",");
					if(obLink.can.loss!=""&&obLink.can.loss!=null)
						sh=sh.concat(" loss="+obLink.can.loss+",");
					if(obLink.can.htb=="True")
						sh=sh.concat(" use_htb="+obLink.can.htb+",");
					
					sh=sh.substring(0, sh.length-1);
					sh=sh.concat(")@@");
					
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);				
				}
				else if((obLink.can.source.name.slice(0,7)=="station"&&(obLink.can.destination.name.slice(0,7)=="station"))){
					cont_mininet++;
					sh = "    net.addLink(sta"+obLink.can.source.name.slice(8,10)+", sta"+obLink.can.destination.name.slice(8,10)+",";
					sh=sh.substring(0, sh.length-1);
					sh=sh.concat(")@@");
					
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);				
				}
			}
		}
		}
	}
	//----------------------------------------------------------------------
	//----------------------------------------------------------------------
	
	for(p=0;p<dropCanvas.numChildren;p++){	
		if(p==0){
			cont_mininet++;
			sh = "@@";
			objeto_mininet=sh;
			temp_mininet.addItem(objeto_mininet);
			cont_mininet++;
			sh = "    print \"*** Starting network\"@@";
			objeto_mininet=sh;
			temp_mininet.addItem(objeto_mininet);
			cont_mininet++;
			sh = "    net.build()@@";
			objeto_mininet=sh;
			temp_mininet.addItem(objeto_mininet);
		}
		UIob = dropCanvas.getChildAt(p);
		if(UIob.className =='objects'){
			ob=UIob as objects;					
			if(ob.isMOtherTemplate==true ||ob.isChildTemplatedOne!=true ){
				if(ob.id=="controllerOpenflow"){	
					cont_mininet++;
					sh = "    c"+ob.name.slice(19,21)+".start()@@";
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);
				}
			}
		}
	}
	for(p=0;p<dropCanvas.numChildren;p++){
		UIob = dropCanvas.getChildAt(p);
		if(UIob.className=='Link'){
			obLink=UIob as Link;			
			if(obLink.can.isMOtherTemplate==true || obLink.can.isChildTemplatedOne!=true ){		
				if(exists==false && storeConnectivity.indexOf(obLink.can.source.name.slice(15,17))==-1 && (obLink.can.source.name.slice(0,14)=="switchOpenflow"||obLink.can.source.name.slice(0,14)=="wirelessRouter")&&obLink.can.destination.name.slice(0,18)=="controllerOpenflow"){
					storeConnectivity.push(obLink.can.source.name.slice(15,17));	
					cont_mininet++;
					sh = "    s"+obLink.can.source.name.slice(15,17)+".start( [c"+obLink.can.destination.name.slice(19,21);
					countControllerDestination=obLink.can.destination.name.slice(19,21);	
					countSwitchSource=obLink.can.source.name.slice(15,17);
					exists=true;
					for(var o:int=0;o<dropCanvas.numChildren;o++){
						UIob = dropCanvas.getChildAt(o);
						if(UIob.className=='Link'){
							obLink=UIob as Link;
							if(obLink.can.destination.name.slice(19,21)!="" && (obLink.can.source.name.slice(15,17)==countSwitchSource) && (obLink.can.destination.name.slice(19,21)!=countControllerDestination)){
								sh = sh+",c"+obLink.can.destination.name.slice(19,21);
								countControllerDestination=obLink.can.destination.name.slice(19,21);
							}
							else if((obLink.can.destination.name.slice(15,17)==countSwitchSource) && (obLink.can.destination.name.slice(0,14)=="switchOpenflow") && (obLink.can.source.name.slice(0,18)=="controllerOpenflow")){
								sh = sh+",c"+obLink.can.source.name.slice(19,21);
								countControllerSource=obLink.can.source.name.slice(19,21);
							}
						}						
					}	
				
					sh = sh+"] )@@";
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);
				}
				else if(exists==false && storeConnectivity.indexOf(obLink.can.destination.name.slice(15,17))==-1 && (obLink.can.destination.name.slice(0,14)=="switchOpenflow"||obLink.can.destination.name.slice(0,14)=="wirelessRouter")&&obLink.can.source.name.slice(0,18)=="controllerOpenflow"){
					storeConnectivity.push(obLink.can.destination.name.slice(15,17));	
					cont_mininet++;
					sh = "    s"+obLink.can.destination.name.slice(15,17)+".start( [c"+obLink.can.source.name.slice(19,21);
					countControllerSource=obLink.can.source.name.slice(19,21);	
					countSwitchDestination=obLink.can.destination.name.slice(15,17);	
					exists=true;
					for(o=0;o<dropCanvas.numChildren;o++){
						UIob = dropCanvas.getChildAt(o);
						if(UIob.className=='Link'){
							obLink=UIob as Link;							
							if(obLink.can.source.name.slice(19,21)!="" && (obLink.can.destination.name.slice(15,17)==countSwitchDestination) && (obLink.can.source.name.slice(19,21)!=countControllerSource)){
								sh = sh+",c"+obLink.can.source.name.slice(19,21);
								countControllerSource=obLink.can.source.name.slice(19,21);	
								Alert.show(String(countSwitchDestination));
							}
							else if((obLink.can.source.name.slice(15,17)==countSwitchDestination) && (obLink.can.source.name.slice(0,14)=="switchOpenflow") && (obLink.can.destination.name.slice(0,18)=="controllerOpenflow")){
								sh = sh+",c"+obLink.can.destination.name.slice(19,21);
								countControllerDestination=obLink.can.destination.name.slice(19,21);
							}
						}						
					}	
					sh = sh+"] )@@";
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);
				}
								
			}
			else if(obLink.can.isChildTemplatedOne==true){
				if(exists==false && storeConnectivity.indexOf(obLink.can.source.name.slice(15,17))==-1 && (obLink.can.source.name.slice(0,14)=="switchOpenflow"||obLink.can.source.name.slice(0,14)=="wirelessRouter")&&obLink.can.destination.name.slice(0,18)=="controllerOpenflow"){
					storeConnectivity.push(obLink.can.source.name.slice(15,17));	
					cont_mininet++;
					sh = "    s"+obLink.can.source.name.slice(15,17)+".start( [c"+obLink.can.destination.name.slice(19,21);
					countControllerDestination=obLink.can.destination.name.slice(19,21);	
					countSwitchSource=obLink.can.source.name.slice(15,17);
					exists=true;
					for(o=0;o<dropCanvas.numChildren;o++){
						UIob = dropCanvas.getChildAt(o);
						if(UIob.className=='Link'){
							obLink=UIob as Link;
							if(obLink.can.destination.name.slice(19,21)!="" && (obLink.can.source.name.slice(15,17)==countSwitchSource) && (obLink.can.destination.name.slice(19,21)!=countControllerDestination)){
								sh = sh+",c"+obLink.can.destination.name.slice(19,21);
								countControllerDestination=obLink.can.destination.name.slice(19,21);
							}
							else if((obLink.can.destination.name.slice(15,17)==countSwitchSource) && (obLink.can.destination.name.slice(0,14)=="switchOpenflow") && (obLink.can.source.name.slice(0,18)=="controllerOpenflow")){
								sh = sh+",c"+obLink.can.source.name.slice(19,21);
								countControllerSource=obLink.can.source.name.slice(19,21);
							}
						}						
					}	
					
					sh = sh+"] )@@";
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);
				}
				else if(exists==false && storeConnectivity.indexOf(obLink.can.destination.name.slice(15,17))==-1 && (obLink.can.destination.name.slice(0,14)=="switchOpenflow"||obLink.can.destination.name.slice(0,14)=="wirelessRouter")&&obLink.can.source.name.slice(0,18)=="controllerOpenflow"){
					storeConnectivity.push(obLink.can.destination.name.slice(15,17));	
					cont_mininet++;
					sh = "    s"+obLink.can.destination.name.slice(15,17)+".start( [c"+obLink.can.source.name.slice(19,21);
					countControllerSource=obLink.can.source.name.slice(19,21);	
					countSwitchDestination=obLink.can.destination.name.slice(15,17);	
					exists=true;
					for(o=0;o<dropCanvas.numChildren;o++){
						UIob = dropCanvas.getChildAt(o);
						if(UIob.className=='Link'){
							obLink=UIob as Link;							
							if(obLink.can.source.name.slice(19,21)!="" && (obLink.can.destination.name.slice(15,17)==countSwitchDestination) && (obLink.can.source.name.slice(19,21)!=countControllerSource)){
								sh = sh+",c"+obLink.can.source.name.slice(19,21);
								countControllerSource=obLink.can.source.name.slice(19,21);	
								Alert.show(String(countSwitchDestination));
							}
							else if((obLink.can.source.name.slice(15,17)==countSwitchDestination) && (obLink.can.source.name.slice(0,14)=="switchOpenflow") && (obLink.can.destination.name.slice(0,18)=="controllerOpenflow")){
								sh = sh+",c"+obLink.can.destination.name.slice(19,21);
								countControllerDestination=obLink.can.destination.name.slice(19,21);
							}
						}						
					}	
					sh = sh+"] )@@";
					objeto_mininet=sh;
					temp_mininet.addItem(objeto_mininet);
				}				
			}
			
		} 
		countSwitchDestination="";
		countSwitchSource="";
		countControllerDestination="";
		countControllerSource="";
		exists=false;
	}	
	//----------------------------------------------------------------------
	//----------------------------------------------------------------------
	cont_mininet++;
	sh = "@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "    print \"*** Running CLI\"@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "    CLI( net )@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "    print \"*** Stopping network\"@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "    net.stop()@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "if __name__ == '__main__':@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "    setLogLevel( 'info' )@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "    topology()@@";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	cont_mininet++;
	sh = "";
	objeto_mininet=sh;
	temp_mininet.addItem(objeto_mininet);
	
	if(expo==true){
		//alertpy2();
		
		var rand:Number = Math.random();
		var numeroRan:Number = Math.round(rand * 99999);
		chave = "mininetScript"+String(numeroRan);
		objSend.chave=chave;
		objSend.count2=cont_mininet;
		objSend.gtemp_mininet=temp_mininet;		
		createscript_mininet.send(objSend);
		fileRefScript_mininet = new FileReference();	
		fileRefScript_mininet.addEventListener(Event.COMPLETE, SaveToLocalMachineResultScript);
		fileRefScript_mininet.addEventListener(ProgressEvent.PROGRESS, downloading_progress);				
		//var request:URLRequest = new URLRequest("./scripts/"+chave+".sh");
		//fileRefScript_mininet.download(request); 
		//fileRefScript_mininet.download(new URLRequest("./scripts/"+chave+".sh"));
		downloadScript();
	
	}		
}
