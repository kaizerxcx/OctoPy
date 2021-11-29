using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Death_Menu : MonoBehaviour
{
    [SerializeField] GameObject deathMenu;

    public void Death()
    {
        deathMenu.SetActive(true);
        Time.timeScale = 1f;
    }


}
