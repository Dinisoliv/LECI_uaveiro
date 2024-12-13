package aula09;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PlaneManager {
    Map<String, Plane> planeMap;
    List<CommercialPlane> comercialPlanes;
    List<MilitaryPlane> militaryPlanes;

    public PlaneManager(){
        planeMap = new HashMap<>();
        comercialPlanes = new ArrayList<>();
        militaryPlanes = new ArrayList<>();
    }

    public void addPlane(Plane plane){
        planeMap.put(plane.getId(), plane);
        if (plane instanceof CommercialPlane) {
            comercialPlanes.add((CommercialPlane)plane);
        }
        else if (plane instanceof MilitaryPlane) {
            militaryPlanes.add((MilitaryPlane)plane);
        }
    }

    public void removePlane(String id){
        Plane removedPlane = planeMap.remove(id);
        if (removedPlane != null) {
            if (removedPlane instanceof CommercialPlane) {
                comercialPlanes.remove((CommercialPlane) removedPlane);
            }
            else if (removedPlane instanceof MilitaryPlane) {
                militaryPlanes.remove((MilitaryPlane) removedPlane);
            }
        }
    }

    public Plane searchPlane(String id){
        return planeMap.get(id);
    }

    public List<CommercialPlane> getCommercialPlanes(){
        return comercialPlanes;
    }

    public List<MilitaryPlane> getMilitaryPlanes(){
        return militaryPlanes;
    }

    public void printAllPlanes(){
        for (Plane plane : planeMap.values()) {
            System.out.println(plane);
        }
    }

    public Plane getFastestPlane(){
        Plane fastestPlane = null;
        int maxSpeed = Integer.MIN_VALUE;
        for (Plane plane : planeMap.values()) {
            if (plane.getMaxSpeed() > maxSpeed) {
                fastestPlane = plane;
                maxSpeed = plane.getMaxSpeed();
            }
        }
        
        return fastestPlane;
    }
}
