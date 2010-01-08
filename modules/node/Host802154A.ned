package org.mixim.modules.node;

import org.mixim.base.modules.BaseMobility;
import org.mixim.base.modules.BaseUtility;
import org.mixim.modules.application.TestApplication;
import org.mixim.modules.netw.DummyRoute;
import org.mixim.modules.utility.phyPER;
import org.mixim.modules.nic.Nic802154A;
import org.mixim.modules.power.battery.SimpleBattery;
import org.mixim.modules.power.battery.BatteryStats;

module Host802154A
{
    parameters:
        double numHosts; // total number of hosts in the network

        @display("bgb=180,200,white,,;bgp=10,10");
    gates:
        input radioIn;

    submodules:
        batteryStats: BatteryStats {
            @display("p=239,206;i=block/circle");
        }
        battery: SimpleBattery {
            @display("p=171,206;i=block/control");
        }
        utility: BaseUtility {
            parameters:
                @display("p=130,60;i=block/blackboard");
        }
        mobility: BaseMobility {
            parameters:
                @display("p=130,130;i=block/cogwheel");
        }
        nic: Nic802154A {
            parameters:
                @display("b=32,30;p=60,166;i=block/ifcard");
        }
        net: DummyRoute {
            parameters:
        }
        app: TestApplication {
            parameters:
                @display("p=60,60;i=block/app");

        }
        stats: phyPER { }
        
    connections:
        net.lowerGateOut --> nic.upperGateIn;
        net.lowerGateIn <-- nic.upperGateOut;
        net.lowerControlOut --> nic.upperGateCtrlIn;
        net.lowerControlIn <-- nic.upperGateCtrlOut;

        net.upperGateOut --> app.lowerGateIn;
        net.upperGateIn <-- app.lowerGateOut;
        net.upperControlOut --> app.lowerControlIn;
        net.upperControlIn <-- app.lowerControlOut;


        radioIn --> nic.radioIn;



}
