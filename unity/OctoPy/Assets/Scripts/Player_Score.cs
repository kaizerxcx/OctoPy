using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using TMPro;

public class Player_Score : MonoBehaviour
{
    public int playerScore = 0;
    public GameObject playerScoreUI;
    public GameObject PanelYouWin;

    void Update()
    {
        playerScoreUI.gameObject.GetComponent<TMPro.TextMeshProUGUI>().text = ("" + playerScore);
    }
    void OnTriggerEnter2D(Collider2D trig)
    {
        trig.isTrigger = false;
        playerScore += 10;

        if (trig.tag == "Log")
        {
            PanelYouWin.SetActive(true);
        }
    }
}
