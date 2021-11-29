using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class Instruction_ : MonoBehaviour
{
    public GameObject Panel;
    int counter;

    public void BtnClick()
    {
        counter++;
        if (counter % 2 == 1)
        {
            Panel.gameObject.SetActive(false);
        }
    }
}
