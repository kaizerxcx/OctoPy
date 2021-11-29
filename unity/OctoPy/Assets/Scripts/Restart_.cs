using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Restart_ : MonoBehaviour
{
    public void restartgame_1(int sceneID)
    {
        Time.timeScale = 1f;
        SceneManager.LoadScene(sceneID);
        SceneManager.LoadScene("Vowel1");
    }
    public void restartgame_2(int sceneID)
    {
        Time.timeScale = 1f;
        SceneManager.LoadScene(sceneID);
        SceneManager.LoadScene("Vowel2");
    }
    public void restartgame_3(int sceneID)
    {
        Time.timeScale = 1f;
        SceneManager.LoadScene(sceneID);
        SceneManager.LoadScene("Consonant1");
    }
    public void restartgame_4(int sceneID)
    {
        Time.timeScale = 1f;
        SceneManager.LoadScene(sceneID);
        SceneManager.LoadScene("Consonant2");
    }
}
