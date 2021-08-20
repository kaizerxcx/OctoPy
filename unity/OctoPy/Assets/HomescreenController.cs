using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class HomescreenController : MonoBehaviour
{
    // Start is called before the first frame update
    public Button crazeOnPhonics;
    public Button wordKit;
    void Start()
    {
       /* gameObject.AddComponent<UnityMessageManager>();
        UnityMessageManager.Instance.SendMessageToFlutter("HomeScreen");*/
        crazeOnPhonics.onClick.AddListener(startCraze);
       wordKit.onClick.AddListener(startWord);
    }
    private void FixedUpdate()
    {
        SoundManagerScript.playSound("Homescreen");
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
                Application.Quit();
                return;
            }
        }
    }
    public void startCraze()
    {
        SceneManager.LoadScene("CrazeOnPhonics");
    }
    public void startWord()
    {
        SceneManager.LoadScene("WordKit");
    }
}
