using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
public class backButton : MonoBehaviour
{
    public Button back;
    // Start is called before the first frame update
    void Start()
    {
        back.onClick.AddListener(goback);
    }
    public void goback()
    {
        SceneManager.LoadScene("Homescreen");
      //  Debug.Log("click");
    }
    // Update is called once per frame
    void Update()
    {
        if (Application.platform == RuntimePlatform.Android)
        {
            if (Input.GetKey(KeyCode.Escape))
            {
                // Insert Code Here (I.E. Load Scene, Etc)
                // OR Application.Quit();
                SceneManager.LoadScene("Homescreen");
                return;
            }
        }
    }
}
