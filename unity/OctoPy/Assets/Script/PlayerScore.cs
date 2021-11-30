using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class PlayerScore : MonoBehaviour
{

    private Text scoreText;
    private int score = 0;
    //public GameObject PanelGameover;
    //public GameObject PanelYouWin;
    [SerializeField] GameObject MenuGameover;
    [SerializeField] GameObject MenuWinning;




    void Awake()
    {
        scoreText = GameObject.Find("ScoreText").GetComponent<Text>();
        scoreText.text = "0";

       
    }

    void OnTriggerEnter2D (Collider2D target)
    {

        if (target.tag == "FastFood")
        {
            transform.position = new Vector2(0, 100);
            target.gameObject.SetActive(false);
            StartCoroutine(RestartGame());
            



        }
          if(target.tag == "Fruits" )
            {
                target.gameObject.SetActive(false);
                score++;
            StartCoroutine(SessionManager.updatemazeCrazePoints(SessionManager.user_id, 1));
            scoreText.text = score.ToString ();
               

            if (scoreText.text == "30")
            {
                // StartCoroutine(RestartGame());
                MenuWinning.SetActive(true);

            }
        }


        }




    IEnumerator RestartGame()
    {
        MenuGameover.SetActive(true);
        yield return new WaitForSecondsRealtime (2f);
        //SceneManager.LoadScene(SceneManager.GetActiveScene().name);




    }
    
    
}
